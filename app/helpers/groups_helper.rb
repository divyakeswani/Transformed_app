module GroupsHelper
  def group
    Group.where(organization_id: current_user.organization.id)
  end
end
