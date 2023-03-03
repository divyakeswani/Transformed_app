class RenameRolesToRoleTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :roles, :role_tables
  end
end
