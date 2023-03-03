# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController

  def create
    self.resource = User.invite!(user_params, current_user)

    resource_invited = resource.errors.empty?
    yield resource if block_given?
    if resource_invited
      @profile = resource.create_user_profile(profile_params)
      if @profile.errors.empty?
        params[:group].present? ?
          group_creation(resource) : group_leader_update(resource)
      else
        flash[:notice] = @profile.errors.full_messages
        redirect_to request.referrer
      end
    else
      respond_with_navigational(resource) {
        flash[:notice] = resource.errors.full_messages
        redirect_to request.referrer
      }
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
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        update_password(resource)
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

  def resend_invite
    @user = User.find_by(id: params[:id])
    if @user.created_by_invite? && @user.invitation_accepted? == false
      @user.invite!
      flash[:notice] = 'user reinvited'
      redirect_to request.referrer
    else
      flash[:notice] = 'user already active'
      redirect_to request.referrer
    end
  end

  private

  # Permit the user params here.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :skip_invitation, :invitation_token)
  end

  # Permit the role params here.
  def role_params
    params.require(:role).permit(:role_name)
  end

  # Permit the group params here.
  def group_params
		params.require(:group).permit(:group_name, :organization_id)
  end

  # creating group
	def check_leader_or_member(resource)
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

  # creating membership and role
  def membership_role_of_leader(resource, group)
    OrganizationMembership.create(user_id: resource.id, organization_id: group.organization_id)
    role = Role.find_by(role_name: 'leader')
    UserRole.create(role_id: role.id, user_id: resource.id, organization_id: group.organization_id)
  end

   # creating membership and role
  def membership_role_of_member(resource)
    OrganizationMembership.create(user_id: resource.id, organization_id: resource.invited_by.invited_by.organization.id)
    role = Role.find_by(role_name: 'member')
    UserRole.create(role_id: role.id, user_id: resource.id, organization_id: resource.invited_by.invited_by.organization.id)
  end

  # updating password after accepting invitation
  def update_password(resource)
    resource.update!(user_params) if user_params.present?
  end

  def group_creation(resource)
    if check_leader_or_member(resource)
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
  end

  def group_leader_update(resource)
    group = Group.find_by(id: params[:group_id])
    group.update(leader_id: resource.id)
    membership_role_of_leader(resource, group)
    resource.deliver_invitation
    flash[:notice] = 'Invitation successfully sent'
    redirect_to new_user_invitation_path
  end
end
