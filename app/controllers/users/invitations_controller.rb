# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController

  def create
    self.resource = User.invite!(user_params, current_user)

    resource_invited = resource.errors.empty?
    yield resource if block_given?
    if resource_invited
      @profile = resource.create_user_profile(profile_params)
      if @profile.errors.empty?
        if next_step(resource)
          resource.deliver_invitation
          if is_flashing_format? && resource.invitation_sent_at
            set_flash_message :notice, :send_instructions, email: resource.email
          end
          if method(:after_invite_path_for).arity == 1
            respond_with resource, location: after_invite_path_for(current_inviter)
          else
            respond_with resource, location: after_invite_path_for(current_inviter, resource)
          end
        end
      else
        flash[:notice] = @profile.errors.full_messages
        redirect_to request.referrer
      end
    else
      respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
    end
  end

  def edit
    super
    @user = User.find_by(id: params[:data])
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      update_profile(resource)
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


  private

  def user_params
    params.require(:user).permit(:email, :password, :skip_invitation)
  end

  def role_params
    params.require(:role).permit(:role_name)
  end

  # Permit the new params here.
  def group_params
		params.require(:group).permit(:group_name, :organization_id)
  end

  # do next process
	def next_step(resource)
    if params[:role][:role_name] == 'leader'
      @group = resource.groups.build(group_params)
      if @group.valid?
        @group.save
        membership_role_of_leader(resource, @group) and return true
      else
        flash[:notice] = @group.errors.full_messages
        redirect_to request.referrer and return false
      end
    elsif params[:role][:role_name] == 'member'
      membership_role_of_member(resource) and return true
    end
  end

  # permitting params for creating user_profile
  def profile_params
    params.require(:user_profile).permit(
      :first_name, :last_name, :phone
    )
  end

  def membership_role_of_leader(resource, group)
    OrganizationMembership.create(user_id: resource.id, organization_id: group.organization_id)
    Role.create(role_name: 'leader', user_id: resource.id)
  end

  def membership_role_of_member(resource)
    OrganizationMembership.create(user_id: resource.id, organization_id: resource.invited_by.invited_by.organization.id)
    Role.create(role_name: 'member', user_id: resource.id)
  end

  def update_profile(resource)
    resource.update(profile_params) if profile_params.present
  end
end