# frozen_string_literal: true

# app/controllers/signups_controller.rb
class SignupsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user
  before_action :user_profile, only: :update

  # GET '/signups/:id/edit'
  def edit; end

  # PATCH '/signups/:id'
  def update
    if @user.update(user_params)
      @user.update(confirmed_at: Time.current)
      @user.create_role(role_name: 'admin')
      redirect_to new_user_session_path
      flash[:notice] = 'you have successfully signed-up'
    else
      redirect_to request.referrer
      flash[:notice] = 'You have to fill your password'
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
      :organization_name, :creator_id
    )
  end

  # creating user_profile
  def user_profile
    @profile = @user.create_user_profile(profile_params)
    if @profile.valid?
      organization()
    else
      redirect_to request.referrer
      flash[:notice] = @profile.errors.full_messages
    end
  end

  # creating organization
  def organization
    @org = Organization.create(organization_params)
    unless @org.valid?
      redirect_to request.referrer
      flash[:notice] = @org.errors.full_messages
    end
  end

  # set user
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
