class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: true, unique: true
      t.integer :phone
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
