class CreateOrganizationMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    # add index
    add_index :organization_memberships, %i[user_id organization_id], unique: true
  end
end
