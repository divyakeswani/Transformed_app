# frozen_string_literal: true

# app/presenters/dashboard_presenter.rb
class DashboardPresenter
  def leaders(org)
    @groups = Group.eager_load(:leader).where("groups.organization_id = #{org}").references(:leader)

    @groups
  end

  def members(org)
    @members = User.eager_load(:member).where(roles: {organization_id: org})

    @members
  end
end
