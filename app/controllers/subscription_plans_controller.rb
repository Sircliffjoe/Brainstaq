class SubscriptionPlansController < ApplicationController
  before_action :find_plan, only: [:edit, :update, :show, :subscribe]
  before_action :authorize_admin!, except: [:index, :subscribe, :show]
  protect_from_forgery except: :complete
  # skip_authorize_resource :only => :check_recurring

  def index
    @subscription_plans = SubscriptionPlan.order(cost: :asc)
  end

  def new
    @subscription_plan = SubscriptionPlan.new
  end

  def show
  end

  def create
    if subscription_plan_params[:recurring] == "true"
      result = create_paystack_plan(subscription_plan_params)
      if result["status"] == true
        paystack_plan_code = result["data"]["plan_code"]
        @subscription_plan = SubscriptionPlan.create(subscription_plan_params)
        @subscription_plan.update_attribute(:paystack_plan_code, paystack_plan_code)
        flash[:notice] = "New Plan Successfully Created in System & Paystack"
        redirect_to subscription_plan_path(@subscription_plan)
      else 
        flash[:error] = "Check to ensure the form is properly filled"
        redirect_to new_subscription_plan_path
      end
    else
      @subscription_plan = SubscriptionPlan.new(subscription_plan_params)
      if @subscription_plan.save
        flash[:notice] = "New plan successfully created."
        redirect_to subscription_plan_path(@subscription_plan)
      else
        flash[:error] = "Error creating new plan."
        render :new
      end
    end
  end

  def create_paystack_plan(subscription_plan_params)
    paystackObj = instantiate_paystack
    plans = PaystackPlans.new(paystackObj)
    data = {
            :name => subscription_plan_params[:plan_name],
            :description =>  subscription_plan_params[:description],
            :amount => subscription_plan_params[:cost].to_i * 100,
            :interval => subscription_plan_params[:duration],
            :currency => "NGN"
    }
    result = plans.create(data)
    return result
  end

  def instantiate_paystack
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    return paystackObj
  end 

  def check_recurring
    selected_plan = params[:plan]
    sub_plan = SubscriptionPlan.find(selected_plan)
    if sub_plan.recurring == false
        render status: 200, json: {
            message: "non-recurring"
        }
    else
        render status: 200, json: {
            message: "recurring"
        }
    end
  end

  def fetch_paystack_plan(subscription_plan_id, paystackObj)
    plans = PaystackPlans.new(paystackObj)
    result = plans.get(subscription_plan_id)
  end

  def update_paystack(subscription_plan_id, paystackObj)
    amount = subscription_plan_params[:cost].to_i * 100
    duration = subscription_plan_params[:duration].to_s
    plan_name = subscription_plan_params[:plan_name]
    plans = PaystackPlans.new(paystackObj)
    result = plans.update(
      subscription_plan_id,
      :name => plan_name,
      :amount => amount,
      :interval => duration,
    )
  end

  def update_plan_record
      if @subscription_plan.update(subscription_plan_params)
          flash[:notice] = "Plan Updated"
          redirect_to subscription_plan_path(@subscription_plan)
      else
          flash[:notice] = "#{@subscription_plan.errors.full_messages.first}"
          redirect_to edit_subscription_plan_path
      end
  end

  def failed_plan_fetch
      flash[:notice] = "Couldn't retrieve plan from Paystack"
      redirect_to edit_subscription_plan_path
  end

  def failed_paystack_update
      flash[:notice] = "Plan was not succesfully updated on Paystack"
      redirect_to edit_subscription_plan_path
  end

  def edit
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def destroy
    @subscription_plan = SubscriptionPlan.find(params[:id])
    # Delete associated features first
    @subscription_plan.features.destroy_all
    @subscription_plan.destroy
    redirect_to subscription_plans_path, notice: 'Plan deleted successfully'
  end

  # def update
  #   @subscription_plan = SubscriptionPlan.find(params[:id])

  #   if @subscription_plan.update(subscription_plan_params)
  #     flash[:notice] = "Plan successfully updated."
  #     redirect_to subscription_plan_path(@subscription_plan)
  #   else
  #     flash[:error] = "Error updating plan."
  #     render :edit
  #   end
  # end

  def update
    if @subscription_plan.paystack_plan_code.nil?
      if @subscription_plan.update(subscription_plan_params)
        redirect_to subscription_plan_path(@subscription_plan) 
      else
        flash[:error] = "#{@subscription_plan.errors.full_messages.first}"
        redirect_to edit_subscription_plan_path
      end
    else
      subscription_plan_id = @subscription_plan.paystack_plan_code
      paystackObj = instantiate_paystack
      subscription_plan_present = fetch_paystack_plan(subscription_plan_id, paystackObj)
      update_paystack_plan = subscription_plan_present["status"] == true ? update_paystack(subscription_plan_id, paystackObj) : failed_plan_fetch
      update_paystack_plan["status"] == true ? update_plan_record : failed_paystack_update
    end
  end

  # def subscribe
  #   plan = SubscriptionPlan.find(params[:id])
  #   user = current_user
    
  #   paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
  # 	transactions = PaystackTransactions.new(paystackObj)
    
  #   # Assuming you have a fixed price for each plan, you can set the amount here
  #   amount = plan.cost * 100  # Paystack requires amount in kobo
    
  #   # Initialize the transaction with Paystack
  #   transaction = transactions.initializeTransaction(
  #     email: user.email,
  #     amount: amount,
  #     callback_url: complete_subscription_url
  #   )
    
  #   if transaction.is_a?(Hash) && transaction["status"]
  #     # Save the transaction reference in your database for later use
  #     # This will help you identify the transaction when Paystack sends a callback
  #     Subscription.create(user: user, subscription_plan: plan, transaction_reference: transaction["data"]["reference"])
      
  #     # Redirect the user to Paystack for payment
  #     redirect_to transaction["data"]["authorization_url"]
  #   else
  #     flash[:error] = "Error initiating payment: #{transaction["message"]}"
  #     redirect_to pricing_path
  #   end
  # end
  
  # def complete
  #   # Retrieve the transaction reference from Paystack callback parameters
  #   transaction_reference = params[:reference]
    
  #   # Find the subscription record associated with the transaction reference
  #   subscription = Subscription.find_by(transaction_reference: transaction_reference)
    
  #   if subscription.present?
  #     # Payment was successful
  #     # Update the subscription status or perform any other necessary actions
  #     subscription.update(status: 'active')  # Example: Update subscription status to 'active'
  #     @username = current_user.username
  #     # Redirect the user to a success page or perform any other post-payment actions
  #     render "users/profile"
  #   else
  #     # Payment failed or subscription record not found
  #     # Handle the error or redirect the user to an error page
  #     redirect_to error_path
  #   end
  # end
 

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
