class SignupsController < ApplicationController
  skip_before_action :authenticate_user!
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(update_params)
      @user.update(confirmed_at: Time.current)
      redirect_to new_user_session_path
      flash[:message] = 'you have successfully signed-up'
    else
      redirect_to request.referrer
      flash[:message] = 'You have to fill your password'
    end
  end

  def complete
    @user = User.find_by(email: params[:email])
  end

  private

  def update_params
    params.require(:user).permit(
      :password, :password_confirmation,
      user_profiles_attributes: %i[first_name last_name phone],
      organizations_attributes: %i[organization_name]
    )
  end
end
