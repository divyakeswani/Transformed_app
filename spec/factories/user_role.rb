FactoryBot.define do
  factory :user_role do
    association :role, factory: :admin_role
    association :user, factory: :user
    association :organization, factory: :organization
  end
end