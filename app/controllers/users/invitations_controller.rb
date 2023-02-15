# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController
  def new
    super do |resource|
      resource.build_profile
    end
  end

  def create
    binding.pry
    self.resource = User.invite!() 

    resource_invited = resource.errors.empty?
    yield resource if block_given?

    if resource_invited
      binding.pry
      if is_flashing_format? && resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: resource.email
      end
      if method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
    end
  end

  def update
		raw_invitation_token = user_params[:invitation_token]
		self.resource = accept_resource
		invitation_accepted = resource.errors.empty?

		yield resource if block_given?

		if invitation_accepted
			if resource.class.allow_insecure_sign_in_after_accept
				flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
				set_flash_message :notice, flash_message if is_flashing_format?
				resource.after_database_authentication
				sign_in(resource_name, resource)
				respond_with resource, location: after_accept_path_for(resource)
			else
				set_flash_message :notice, :updated_not_active if is_flashing_format?
				respond_with resource, location: new_session_path(resource_name)
			end
		else
			resource.invitation_token = raw_invitation_token
			respond_with_navigational(resource) { render :edit, status: :unprocessable_entity }
		end
  end

  def build_profile(resource)
		@profile = resource.build_user_profile(profile_params)
    if @profile.valid?
      build_group(resource)
    else
      flash[:notice] = @profile.errors.full_messages
      return
		end
  end

  def build_group(resource)
    @grp = resource.groups.build(group_params)
    unless @grp.valid?
      redirect_to request.referrer
      flash[:notice] = @grp.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :skip_invitation)
  end

  # Permit the new params here.
  def group_params
		params.require(:group).permit(:group_name, :organization_id)
  end

		
  # permitting params for creating user_profile
  def profile_params
    params.require(:user_profile).permit(
      :first_name, :last_name, :phone
    )
  end
end