class Users::InvitationsController < Devise::InvitationsController
  def new
    self.resource = resource_class.new
    render :new
  end
  
  def create
    self.resource = resource_class.invite!(resource_params_with_username, current_inviter)

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions, :email => self.resource.email
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end


  private

  def resource_params
    params.require(resource_name).permit(:username, :email, :invitation_token, :password, :password_confirmation)
  end

  def resource_params_with_username
    p = params.require(resource_name).permit(:email).dup
    email = resource_params[:email]
    email ? p.merge(:username => email.split('@').first) : p
  end
end
