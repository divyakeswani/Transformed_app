module UsersHelper
  def find_invited_user
    User.where(invited_by: current_user)
  end
end
