FactoryBot.define do
	factory :user_profile do
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
    phone { '123456' }
		association :user, factory: :user
	end
end