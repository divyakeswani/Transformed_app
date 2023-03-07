FactoryBot.define do
	factory :group_member do
		association :member, factory: :user
		association :group, factory: :group
	end
end