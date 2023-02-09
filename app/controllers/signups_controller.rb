class SignupsController < ApplicationController
  skip_before_action :authenticate_user!
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if (params[:first_name] && params[:phone] && params[:organization_name]).present?
      update_user()
    else
      redirect_to request.referrer
      flash[:notice] = 'You have to fill required fields'
    end
  end

  private

  def update_params
    params.require(:user).permit(
      :password, :password_confirmation
    )
  end

  def update_user()
    if @user.update(update_params)
      @user.update(confirmed_at: Time.current)
      user_profile()
      organization()
      redirect_to new_user_session_path
      flash[:notice] = 'you have successfully signed-up'
    else
      redirect_to request.referrer
      flash[:notice] = 'You have to fill your password'
    end
  end

  def user_profile
    @user.create_user_profile(first_name: params[:first_name], last_name:
      params[:last_name], phone: params[:phone])
  end

  def organization
    binding.pry
    @user.create_organization(organization_name: params[:organization_name])
  end
end
