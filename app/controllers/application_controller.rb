class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CommentsHelper
  
  protect_from_forgery with: :exception
  before_action :set_cache_headers

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  after_action :user_activity, if: :user_signed_in?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include PublicActivity::StoreController
  
  def resource_name
    :user
  end
  
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [:id, :first_name, :last_name, :image, :username, :country, :website, :phone, :gender, :bio, :email, :password, :password_confirmation, :current_password])
    devise_parameter_sanitizer.permit(:sign_in, 
      keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, 
      keys: [:id, :first_name, :last_name, :image, :username, :country, :website, :phone, :gender, :bio, :email, :password, :password_confirmation, :current_password])
  end
  

  def after_sign_in_path_for(resource)
    if @user == 'admin'
      rails_admin_path
    else
      dashboard_path(current_user.full_name)
    end
  end

  def after_plan_subscription_path_for(resource)
    if @user == 'admin'
      rails_admin_path
    else
      dashboard_path(current_user.full_name)
    end
  end

  private
  
  def set_session
    set_session_id
    @session = Session.new(@session_id)
  end

  def set_session_id
    @session_id = cookies[:user_id] ||= SecureRandom.uuid
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end

  def user_not_authorized
    flash[:alert] =  " You are not authorized to perfome this action"
    redirect_to(request.referrer || root_path)
  end

  def user_activity
    current_user.try :touch
  end

  helper_method :current_user
end
