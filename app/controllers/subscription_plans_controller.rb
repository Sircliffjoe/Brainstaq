class SubscriptionPlansController < ApplicationController
  before_action :find_plan, only: [:edit, :update, :show, :subscribe]
  before_action :authorize_admin!, except: [:index, :subscribe, :show]
  protect_from_forgery except: :complete

  def index
    @subscription_plans = SubscriptionPlan.all
  end

  def new
    @subscription_plan = SubscriptionPlan.new
  end

  def show
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)
    if @subscription_plan.save
      flash[:notice] = "New plan successfully created."
      redirect_to subscription_plan_path(@subscription_plan)
    else
      flash[:error] = "Error creating new plan."
      render :new
    end
  end

  def edit
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def update
    @subscription_plan = SubscriptionPlan.find(params[:id])

    if @subscription_plan.update(subscription_plan_params)
      flash[:notice] = "Plan successfully updated."
      redirect_to subscription_plan_path(@subscription_plan)
    else
      flash[:error] = "Error updating plan."
      render :edit
    end
  end

  def subscribe
    plan = SubscriptionPlan.find(params[:id])
    user = current_user
    
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
  	transactions = PaystackTransactions.new(paystackObj)
    
    # Assuming you have a fixed price for each plan, you can set the amount here
    amount = plan.cost * 100  # Paystack requires amount in kobo
    
    # Initialize the transaction with Paystack
    transaction = transactions.initializeTransaction(
      email: user.email,
      amount: amount,
      callback_url: complete_subscription_url
    )
    
    if transaction.is_a?(Hash) && transaction["status"]
      # Save the transaction reference in your database for later use
      # This will help you identify the transaction when Paystack sends a callback
      Subscription.create(user: user, subscription_plan: plan, transaction_reference: transaction["data"]["reference"])
      
      # Redirect the user to Paystack for payment
      redirect_to transaction["data"]["authorization_url"]
    else
      flash[:error] = "Error initiating payment: #{transaction["message"]}"
      redirect_to pricing_path
    end
  end
  
  def complete
    # Retrieve the transaction reference from Paystack callback parameters
    transaction_reference = params[:reference]
    
    # Find the subscription record associated with the transaction reference
    subscription = Subscription.find_by(transaction_reference: transaction_reference)
    
    if subscription.present?
      # Payment was successful
      # Update the subscription status or perform any other necessary actions
      subscription.update(status: 'active')  # Example: Update subscription status to 'active'
      @username = current_user.username
      # Redirect the user to a success page or perform any other post-payment actions
      render "users/profile"
    else
      # Payment failed or subscription record not found
      # Handle the error or redirect the user to an error page
      redirect_to error_path
    end
  end
 

  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end

  def find_plan
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def subscription_plan_params
    params.require(:subscription_plan) 
      .permit(:id, :plan_name, :cost, :description, :status, :duration, :recurring, 
      features_attributes: [:id, :_destroy, :name, :description])
  end
end
