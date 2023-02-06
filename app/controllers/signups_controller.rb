class SignupsController < ApplicationController
  skip_before_action :authenticate_user!
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(update_params)
    @user.update(confirmed_at: Time.current)
    redirect_to new_user_session_path
    flash[:message] = 'you have successfully signed-up'
  end

  def complete
    @user = User.find_by(email: params[:email])
  end

  private

  def update_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      user_profile: %i[first_name last_name phone],
      organization_profile: %i[organization_name]
    )
  end
end
