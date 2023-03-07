FactoryBot.define do
  factory :role do
    trait :admin do
      role_name { 'admin' }
    end
    
    trait :leader do
      role_name { 'leader' }
    end
    
    trait :member do
      role_name { 'member' }
    end
    
    factory :admin_role, traits: [:admin]
    factory :leader_role, traits: [:leader]
    factory :member_role, traits: [:member]
  end
end
