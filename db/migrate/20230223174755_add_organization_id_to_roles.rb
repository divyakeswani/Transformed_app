class AddOrganizationIdToRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :organization_id, :integer, null: false, foreign_key: true
  end
end
