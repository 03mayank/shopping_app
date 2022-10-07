FactoryBot.define do
  factory :address do
    association :user
    area { '739, Jagrati Nagar' }
    city { 'Indore' } 
    pincode { '452001' }
    state { 'MP'}
  end
end
