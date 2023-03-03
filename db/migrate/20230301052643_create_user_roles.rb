class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.integer :role_id, null: false
      t.integer :organization_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :user_roles, [:role_id, :organization_id, :user_id], :unique => true
  end
end
