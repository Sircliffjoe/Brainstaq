class SessionsController < Devise::SessionsController
  respond_to :html, :js
  
  def create
    self.resource = warden.authenticate(auth_options)
    if resource.present?
      sign_in(resource_name, resource)
      respond_to do |format|
        format.html { respond_with(resource, location: after_sign_in_path_for(resource)) }
        format.js { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_session_path, alert: 'Invalid email or password.' }
        format.js { render json: { success: false, error: 'Invalid email or password.' } }
      end
    end
  end
  
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.js { render json: { signed_out: signed_out } }
    end
  end
end
