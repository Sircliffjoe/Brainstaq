class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Display current user's subscriptions (implement logic)
    @subscriptions = current_user.subscriptions.active.order(created_at: :desc)
  end

  def new
    @subscription = current_user.subscriptions.build
    @subscription_plans = SubscriptionPlan.all.active
  end

  def create
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])

    if @subscription_plan.free?
      # Handle free plan subscription (no payment required)
      @subscription = current_user.subscriptions.create!(subscription_plan: @subscription_plan)
      flash[:notice] = "Subscribed to free plan!"
      redirect_to subscription_path(@subscription)
    else
      # Initiate payment for paid plans using Paystack
      begin
        @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])

        transaction_data = {
          :email => current_user.email,
          :plan => @subscription_plan.code
        }

        result = @paystackObj.initializeTransaction(transaction_data)

        if result['status'] == true
          auth_url = result['data']['authorization_url']
          redirect_to auth_url
        else
          flash[:error] = "Payment initialization failed: #{result['message']}"
          redirect_to new_subscription_path
        end
      rescue StandardError => e
        flash[:error] = "An error occurred: #{e.message}"
        redirect_to new_subscription_path
      end
    end
  end

  def show
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def update
    # Handle subscription updates (if applicable)
    # Consider authorization checks
    if @subscription.update(subscription_params)
      flash[:notice] = "Subscription successfully updated!"
      redirect_to subscription_path(@subscription)
    else
      flash[:error] = "Failed to update subscription."
      redirect_to subscription_path(@subscription)
    end
  end

  def upgrade
    new_plan = SubscriptionPlan.find(params[:new_subscription_plan_id])

    # Implement upgrade logic with validation and authorization checks
    if @subscription.upgrade_to?(new_plan) && @subscription.update(subscription_plan: new_plan)
      flash[:notice] = "Subscription successfully upgraded!"
      redirect_to subscription_path(@subscription)
    else
      flash[:error] = "Upgrade failed: Subscription cannot be upgraded."
      redirect_to subscription_path(@subscription)
    end
  end

  def callback
    begin
      @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])

      transaction_reference = params[:trxref]
      result = @paystackObj.verifyTransaction(transaction_reference)

      if result['data']['status'] == "success"
        process_payment(result)
      else
        flash[:error] = "Payment failed: #{result['message']}"
      end
    rescue StandardError => e
      flash[:error] = "An error occurred: #{e.message}"
    end
  end

  def cancel
    # Implement subscription cancellation logic with authorization checks
    if @subscription.cancel!
      flash[:notice] = "Subscription successfully cancelled!"
      redirect_to root_path
    else
      flash[:error] = "Cancellation failed: Subscription could not be cancelled."
      redirect_to subscription_path(@subscription)
    end
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Subscription not found."
    redirect_to root_path
  end

  def subscription_params
    # Update based on your specific permitted parameters
    params.require(:subscription).permit(:subscription_plan_id)
  end

  def process_payment(result)
    # Find the associated subscription based on payment information
    subscription = Subscription.find_by(payment_reference: result['data']['reference'])
  
    # Update subscription status based on payment outcome
    if result['data']['status'] == "success"
      subscription.update!(status: :active, payment_date: Time.now)
    else
      subscription.update!(status: :failed)
      # Optionally, handle failed payments gracefully (e.g., notify user, retry)
    end
  
    # Update user attributes (e.g., assign paid user role)
    user = subscription.user
    user.update!(paid_user: true)
  
    # Send confirmation emails or notifications
    SubscriptionMailer.with(subscription: subscription).payment_confirmation.deliver_later
  
    # Perform any additional actions based on your subscription system logic
    # (e.g., activate user features, grant access to premium content)
  end
end
