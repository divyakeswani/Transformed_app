class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.references :user, null: false, foreign_key: true, index: true, unique: true
      t.string :role_name, null: false, default: ''

      t.timestamps
    end
  end
end
