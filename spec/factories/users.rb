FactoryBot.define do
  
  factory :user do
    first_name { 'first' }
    last_name { 'last' }
    password { '1234' }
    email {'mayank@mayank.com'}
    mobile {'9630215487'}
  end
end