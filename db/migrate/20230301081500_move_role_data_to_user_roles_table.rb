class MoveRoleDataToUserRolesTable < ActiveRecord::Migration[7.0]
  def change
    Role.find_each do |r|
      RoleTable.find_each do |rt|
        if rt.role_name == r.role_name
          UserRole.create(
            role_id: r.id,
            user_id: rt.user_id,
            organization_id: rt.organization_id
          )
        end
      end
    end
  end
end
