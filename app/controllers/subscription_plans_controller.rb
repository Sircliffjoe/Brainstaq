class SubscriptionPlansController < ApplicationController
  before_action :find_plan, only: [:edit, :update, :show, :subscribe]
  before_action :authorize_admin!, except: [:index, :subscribe, :show]

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
    @subscription_plan = Subscription_plan.find(params[:id])
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
    @subscription_plans = SubscriptionPlan.find(params[:id])
    @subscription = current_user.subscriptions.build(subscription_plan: @subscription_plan)
    
    if @subscription.save
      flash[:notice] = "Successfully subscribed to the #{@subscription_plan.plan_name} plan."
      redirect_to root_path
    else
      flash[:error] = "Error subscribing to the plan."
      redirect_back(fallback_location: root_path)
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
