FactoryBot.define do
	factory :group do
		association :leader, factory: :user
		group_name { Faker::Name.first_name }
	end
end
