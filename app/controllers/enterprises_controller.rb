class EnterprisesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [ :index, :show]
  # before_action :require_subscription, only: [:new]
  before_action :set_enterprise, only: [:activate_brand, :deactivate_brand,:show, :edit, :update, :destroy]
  before_action :in_check, except: [ :index, :new, :show, :activate_brand, :deactivate_brand ]
  before_action :check_active, only: [:edit, :update, :destroy]
  
  def in_check
    if user_signed_in?
      if current_user.enterprise
        if current_user.enterprise.status == "inactive" ||  current_user.enterprise.status == nil
          redirect_to new_transaction_path, alert: "#{current_user.enterprise.name} is inactive or expired! Renew your Subscription to gain access."
        end
      end
    end
  end
  
  ENTERPRISES_PER_PAGE = 9

  # GET /enterprises or /enterprises.json
  def index
    if params[:category].blank?
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Enterprise.count >= 9
      @prev_page = @page - 1 if @page < 0
      @enterprises = Enterprise.offset(@page*ENTERPRISES_PER_PAGE).limit(ENTERPRISES_PER_PAGE).order(created_at: :desc)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Enterprise.count >= 9
      @prev_page = @page - 1 if @page < 0
      @enterprises = Enterprise.where(category_id: @category_id).offset(@page*ENTERPRISES_PER_PAGE).limit(ENTERPRISES_PER_PAGE).order(created_at: :desc)
    end
    @enterprises_count = Enterprise.count
  end

  def activate_brand
    if @enterprise.transactions.any?
      @enterprise.update(status: 1)
      redirect_to @enterprise, notice: 'Brand was successfully activated.'
    else
      redirect_to new_transaction_path, alert: 'Brand cannot be activated without an active subscription. Choose a subscription plan.'
    end
  end

  def deactivate_brand
    if @enterprise.transactions.any?
      @enterprise.update(status: 0)
      redirect_to @enterprise, notice: 'Brand was successfully deactivated.'
    else
      redirect_to @enterprise, alert: 'Brand cannot be deactivated without an active subscription.'
    end
  end

  def show
    @enterprise = Enterprise.find(params[:id])
    @business_plan = BusinessPlan.new
    @business_plans = @enterprise.business_plans
    @products_and_growth_rates = @business_plan.products_and_growth_rates
    @portfolios = @enterprise.portfolios
    @services = @enterprise.services
    @business_plan.enterprise_id = @enterprise.id
    @enterprises_count = Enterprise.count

    render :show
  end  

  def new
    if current_user.enterprise.present?
      if current_user.enterprise.status == "inactive"
        redirect_to new_transaction_path, notice: "You already have a brand. You need to choose a subscription plan to activate it."
      else
        redirect_to enterprises_path, notice: "You already have a Brand."
      end
    else 
      @enterprise = Enterprise.new
      # render the new enterprise form
    end
  end

  def edit
  end

  def create
    # @enterprise = current_user.enterprises.build(enterprise_params)
    @enterprise = Enterprise.new(enterprise_params)
    @enterprise.user_id= current_user.id
    @enterprise.status = 0
    @enterprise.save

    respond_to do |format|
      if @enterprise.save
        current_user.increment!(:enterprise_count)
        format.html { redirect_to @enterprise, notice: "Brand was successfully created. You must activate your brand to continue." }
        format.json { render :show, status: :created, location: @enterprise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @enterprise.update(enterprise_params)
        format.html { redirect_to @enterprise, notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @enterprise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @enterprise.destroy
    respond_to do |format|
      format.html { redirect_to enterprises_url, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_enterprise
    @enterprise = Enterprise.find(params[:id])
  end
  
  def check_active
    unless @enterprise.active?
      redirect_to @enterprise, alert: "#{@enterprise.name} is inactive and cannot be edited or deleted."
    end
  end
  

  def enterprise_params
    params.require(:enterprise).permit(:status, :interval, :name, :image, :remove_image, :image_cache, 
      :category_id, :user_id, :address, :email, :phone_number, 
      :country, :state, :city, :info, :facebook_url, :twitter_url, :instagram_url, :website_url)
  end
end
