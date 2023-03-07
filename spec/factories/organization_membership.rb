FactoryBot.define do
	factory :organization_membership do
		association :user, factory: :user
		association :organization, factory: :organization
	end
end
