module GroupsHelper
  def name(user)
    Group.where(leader_id: user.id, organization_id: current_user.organization.id)
  end
end
