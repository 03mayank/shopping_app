FactoryBot.define do
  
  factory :user do
    first_name { 'first' }
    last_name { 'last' }
    password { '1234' }
    email { Faker::Internet.email }
    trait :admin do
      email { admin@sz.com }
    end
    mobile {'9630215487'}
  end
end
