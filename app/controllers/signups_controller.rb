# frozen_string_literal: true

# app/controllers/signups_controller.rb
class SignupsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user
  before_action :user_profile, only: :update
  after_action  -> {membership_and_role(@user, @org)}, only: :update

  # GET '/signups/:id/edit'
  def edit; end

  # PATCH '/signups/:id'
  def update
    if @user.update(user_params)
      @user.update(confirmed_at: Time.current)
      @org.save
      redirect_to new_user_session_path
      flash[:notice] = 'you have successfully signed-up'
    else
      flash[:notice] = 'You have to fill your password'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # permitting params for updating user
  def user_params
    params.require(:user).permit(
      :password, :password_confirmation
    )
  end

  # permitting params for creating user_profile
  def profile_params
    params.require(:user_profile).permit(
      :first_name, :last_name, :phone
    )
  end

  # permitting params for creating organization
  def organization_params
    params.require(:organization).permit(
      :organization_name
    )
  end

  # creating user_profile
  def user_profile
    @profile = @user.create_user_profile(profile_params)
    if @profile.valid?
      organization()
    else
      flash[:notice] = @profile.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  # creating organization
  def organization
    @org = @user.build_organization(organization_params)
    unless @org.valid?
      flash[:notice] = @org.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  # set user
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def membership_and_role(user, org)
    user.create_role(role_name: 'admin', organization_id: org.id)
    user.organization_memberships.create(organization_id: org.id)
  end
end
