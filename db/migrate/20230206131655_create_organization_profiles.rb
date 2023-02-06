class CreateOrganizationProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :organization_name, null: false, default: ''

      t.timestamps
    end
  end
end
