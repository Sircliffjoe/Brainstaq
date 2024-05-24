class SubscriptionPlansController < ApplicationController
  before_action :find_plan, only: [:edit, :update, :show, :subscribe]
  before_action :authorize_admin!, except: [:index, :subscribe, :show]
  protect_from_forgery except: :complete
  # skip_authorize_resource :only => :check_recurring

  def index
    @subscription_plans = SubscriptionPlan.order(cost: :asc)
    @enterprises_count = Enterprise.count
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


  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
  end

  def find_plan
    @subscription_plan = SubscriptionPlan.find_by(paystack_plan_code: params[:id])
    unless @subscription_plan
      flash[:alert] = "Subscription plan not found"
      redirect_to root_path
    end
  end
  

  def subscription_plan_params
    params.require(:subscription_plan) 
      .permit(:id, :plan_name, :cost, :description, :status, :duration, :recurring, 
      features_attributes: [:id, :_destroy, :name, :description])
  end
end
