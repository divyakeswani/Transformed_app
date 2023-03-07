FactoryBot.define do
	factory :organization do
		organization_name { Faker::Name.first_name }
		association :creator, factory: :user
	end
end