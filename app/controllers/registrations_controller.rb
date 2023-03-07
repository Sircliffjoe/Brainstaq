class RegistrationsController < Devise::RegistrationsController

  prepend_before_action :check_captcha, only: [:create]
  
  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, 
      :username, :country, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:id, :first_name, :last_name, :image, :image_url, :username, :country, :website, 
      :phone, :gender, :bio, :email, :password, :password_confirmation, :current_password, 
      :facebook_url, :twitter_url, :instagram_url, :linkedin_url)
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end
      
  def after_update_path_for(resource)
    profile_path(current_user.username)
  end

  def check_captcha
    return if verify_recaptcha # verify_recaptcha(action: 'signup') for v3

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      render :new
    end
  end
  
end
   

  