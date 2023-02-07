class CreateGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :group_members do |t|
      t.references :group, null: false, foreign_key: true, index: true, unique: true
      t.integer :member_id, null: false

      t.timestamps
    end

    # Add Foreign key user_id as creator_id
    add_foreign_key :group_members, :users, column: :member_id

    # UNIQE index of group_id and member_id
    add_index :group_members, [:group_id, :member_id], unique: true
  end
end
