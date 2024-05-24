class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subscription, only: [:show, :update, :cancel]
  
  def index
    user = User.find_by_username(params[:id])

    if user == current_user || current_user.admin
      @subscription = user.subscription
      @transactions = user.transactions.paginate(:page => params[:page], :per_page => 2)
      render :index
    else
      render json:   { message: "You're not authorized to access this page" }, status: :unauthorized
    end
  end

  def new
    @subscription = current_user.subscriptions.build
    @subscription_plans = SubscriptionPlan.all.active
  end

  def create
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])

    if @subscription_plan.free?
      @subscription = current_user.subscriptions.create!(subscription_plan: @subscription_plan)
      flash[:notice] = "Subscribed to free plan!"
      redirect_to subscription_path(@subscription)
    else
      initiate_payment
    end
  end

  def show
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def update
    if @subscription.update(subscription_params)
      flash[:notice] = "Subscription successfully updated!"
      redirect_to subscription_path(@subscription)
    else
      flash[:error] = "Failed to update subscription."
      redirect_to subscription_path(@subscription)
    end
  end

  def cancel
    @subscription = current_user.subscriptions.find(params[:id])

    if @subscription.cancel!  # Replace with your custom cancellation logic
      flash[:notice] = "Subscription successfully cancelled!"
      redirect_to root_path
    else
      flash[:error] = "Cancellation failed: Subscription could not be cancelled."
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

  def upgrade
    @subscription = current_user.subscriptions.find(params[:id])
    new_plan = SubscriptionPlan.find(params[:new_subscription_plan_id])
  
    # Check for existing active subscriptions
    if current_user.subscriptions.active.any? && @subscription.id != current_user.subscriptions.active.first.id
      redirect_to subscription_path(@subscription), alert: "You already have an active subscription."
      return
    end
  
    # Proceed with upgrade logic if no active subscription conflicts
    if @subscription.upgrade_to?(new_plan) && @subscription.update(subscription_plan: new_plan)
      pay_for_upgrade(new_plan)

      flash[:notice] = "Subscription successfully upgraded!"
      redirect_to subscription_path(@subscription)
    else
      flash[:error] = "Upgrade failed: Subscription cannot be upgraded."
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
    params.require(:subscription).permit(:subscription_plan_id)
  end

  def initiate_payment
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

  def process_payment(reference)
    paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    result = paystack.verifyTransaction(reference)

    if result['data']['status'] == "success"
      subscription = current_user.subscriptions.find_by(transaction_reference: reference)
      subscription.update!(status: :active, payment_date: Time.now)

      current_user.update!(paid_user: true)

      SubscriptionMailer.with(subscription: subscription).payment_confirmation.deliver_later

      flash[:notice] = "Payment successful!"
    else
      flash[:error] = "Payment failed: #{result['message']}"
    end
  rescue StandardError => e
    flash[:error] = "An error occurred: #{e.message}"
  end

  def pay_for_upgrade(new_plan)
    paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    transaction_data = { email: current_user.email, plan: new_plan.code }
    result = paystack.initializeTransaction(transaction_data)
  
    if result['status'] == true
      redirect_to result['data']['authorization_url']
    else
      flash[:error] = "Payment initialization failed: #{result['message']}"
      redirect_to subscription_path(@subscription)
    end
  rescue StandardError => e
    flash[:error] = "An error occurred: #{e.message}"
    redirect_to subscription_path(@subscription)
  end
end

