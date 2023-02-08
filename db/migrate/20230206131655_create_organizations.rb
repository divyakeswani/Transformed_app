class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.integer :creator_id, null: false
      t.string :organization_name, null: false, default: ''

      t.timestamps
    end

    # Add Foreign key user_id as creator_id
    add_foreign_key :organizations, :users, column: :creator_id, unique: true

  end
end
