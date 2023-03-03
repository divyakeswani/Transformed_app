class DropRoleTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :role_tables
  end
end
