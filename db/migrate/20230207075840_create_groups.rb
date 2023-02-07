class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :organization, null: false,
        foreign_key: true, index: true, unique: true
      t.integer :leader_id, null: false
      t.string :group_name, null: false, default: ''

      t.timestamps
    end

    # Add Foreign key user_id as creator_id
    add_foreign_key :groups, :users, column: :leader_id

    # UNIQE index of organization_id and group_name
    add_index :organizations, [:organization_id, :group_name], unique: true
  end
end
