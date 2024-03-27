# class SubscriptionsController < ApplicationController
#   before_action :authenticate_user!

#   def index
#     # Display current user's subscriptions (implement logic)
#     @subscriptions = current_user.subscriptions.active.order(created_at: :desc)
#   end

#   def new
#     @subscription = current_user.subscriptions.build
#     @subscription_plans = SubscriptionPlan.all.active
#   end

#   def create
#     @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])

#     if @subscription_plan.free?
#       # Handle free plan subscription (no payment required)
#       @subscription = current_user.subscriptions.create!(subscription_plan: @subscription_plan)
#       flash[:notice] = "Subscribed to free plan!"
#       redirect_to subscription_path(@subscription)
#     else
#       # Initiate payment for paid plans using Paystack
#       begin
#         @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])

#         transaction_data = {
#           :email => current_user.email,
#           :plan => @subscription_plan.code
#         }

#         result = @paystackObj.initializeTransaction(transaction_data)

#         if result['status'] == true
#           auth_url = result['data']['authorization_url']
#           redirect_to auth_url
#         else
#           flash[:error] = "Payment initialization failed: #{result['message']}"
#           redirect_to new_subscription_path
#         end
#       rescue StandardError => e
#         flash[:error] = "An error occurred: #{e.message}"
#         redirect_to new_subscription_path
#       end
#     end
#   end

#   def show
#     @subscription = current_user.subscriptions.find(params[:id])
#   end

#   def update
#     # Handle subscription updates (if applicable)
#     # Consider authorization checks
#     if @subscription.update(subscription_params)
#       flash[:notice] = "Subscription successfully updated!"
#       redirect_to subscription_path(@subscription)
#     else
#       flash[:error] = "Failed to update subscription."
#       redirect_to subscription_path(@subscription)
#     end
#   end

#   def upgrade
#     new_plan = SubscriptionPlan.find(params[:new_subscription_plan_id])

#     # Implement upgrade logic with validation and authorization checks
#     if @subscription.upgrade_to?(new_plan) && @subscription.update(subscription_plan: new_plan)
#       flash[:notice] = "Subscription successfully upgraded!"
#       redirect_to subscription_path(@subscription)
#     else
#       flash[:error] = "Upgrade failed: Subscription cannot be upgraded."
#       redirect_to subscription_path(@subscription)
#     end
#   end

#   def callback
#     begin
#       @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])

#       transaction_reference = params[:trxref]
#       result = @paystackObj.verifyTransaction(transaction_reference)

#       if result['data']['status'] == "success"
#         process_payment(result)
#       else
#         flash[:error] = "Payment failed: #{result['message']}"
#       end
#     rescue StandardError => e
#       flash[:error] = "An error occurred: #{e.message}"
#     end
#   end

#   def cancel
#     # Implement subscription cancellation logic with authorization checks
#     if @subscription.cancel!
#       flash[:notice] = "Subscription successfully cancelled!"
#       redirect_to root_path
#     else
#       flash[:error] = "Cancellation failed: Subscription could not be cancelled."
#       redirect_to subscription_path(@subscription)
#     end
#   end

#   private

#   def find_subscription
#     @subscription = current_user.subscriptions.find(params[:id])
#   rescue ActiveRecord::RecordNotFound
#     flash[:error] = "Subscription not found."
#     redirect_to root_path
#   end

#   def subscription_params
#     # Update based on your specific permitted parameters
#     params.require(:subscription).permit(:subscription_plan_id)
#   end

#   def process_payment(result)
#     # Find the associated subscription based on payment information
#     subscription = Subscription.find_by(payment_reference: result['data']['reference'])
  
#     # Update subscription status based on payment outcome
#     if result['data']['status'] == "success"
#       subscription.update!(status: :active, payment_date: Time.now)
#     else
#       subscription.update!(status: :failed)
#       # Optionally, handle failed payments gracefully (e.g., notify user, retry)
#     end
  
#     # Update user attributes (e.g., assign paid user role)
#     user = subscription.user
#     user.update!(paid_user: true)
  
#     # Send confirmation emails or notifications
#     SubscriptionMailer.with(subscription: subscription).payment_confirmation.deliver_later
  
#     # Perform any additional actions based on your subscription system logic
#     # (e.g., activate user features, grant access to premium content)
#   end
# end

class SubscriptionsController < ApplicationController
  before_action :initialize_paystack_service
  rescue_from SocketError, with: :handle_offline

  def pricing
    @plans = fetch_paystack_plans
  end
  
  def handle_payments
    if customer_exists
      initialize_transaction
    else
      create_customer
    end
  end

  def customer_exists
    response = @paystack_service.fetch_customer_details(current_user)
    response['status']
  end

  def create_customer
    response = @paystack_service.create_customer(current_user)

    return unless response['status']

    initialize_transaction
  end

  def initialize_transaction
    response = @paystack_service.initialize_transaction(current_user)

    if response['status']
      payment_link = response['data']['authorization_url']
      redirect_to payment_link, allow_other_host: true
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed_to_initialize')
    end
  end

  def paystack_callback
    response = @paystack_service.verify_transaction(params[:reference])

    if response['status']
      create_subscription
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed_verification')
    end
  end

  def create_subscription
    response = @paystack_service.create_subscription(current_user, ENV.fetch('PLAN_ID', nil))

    if response['status']
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed')
    end
  end

  def manage_subscription
    response = @paystack_service.get_manage_subscription_link(current_user)
    session[:manage_subscription_link] = response
    redirect_to user_path(current_user)
  end

  private

  def initialize_paystack_service
    @paystack_service = PaystackService.new(ENV.fetch('PAYSTACK_SECRET_KEY', nil))
  end

  def get_plan_amount(plan_id)
    # Implement logic to retrieve the plan amount based on the plan ID (e.g., from a pricing table)
  end

  def fetch_paystack_plans
    @paystack_service = PaystackService.new(ENV.fetch('PAYSTACK_SECRET_KEY', nil))
  
    response = @paystack_service.get('/plan')
    if response['status']
      plans_data = response['data']

      plans_data.map do |plan_data|
        {
          id: plan_data['id'],
          plan_name: plan_data['name'],
          amount: plan_data['amount'],
          interval: plan_data['interval'],
          plan_code: plan_data['plan_code'],
          description: plan_data['description']
        }
      end
    else
      raise StandardError, "Error fetching plans from Paystack: #{response['message']}"
    end
  end

  def handle_offline
    # redirect_to user_path(current_user), alert: t('subscriptions.offline')
    flash[:alert] = 'Network error. Please try again later.'
    redirect_to pricing_path
  end
end

