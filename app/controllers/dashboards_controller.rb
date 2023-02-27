# frozen_string_literal: true

# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  def index
    if current_user.role.role_name == 'admin'
      org = current_user.organization.id
      @groups = DashboardPresenter.new.groups(org)
      @members = DashboardPresenter.new.members(org)

      @u = User.includes(:groups).where("groups.organization_id = #{org}").references(:groups)
    end
  end
end