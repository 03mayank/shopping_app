FactoryBot.define do
  factory :order do
    association :user
    address { '25, Shiv Shakti Nagar, Indore, MP, Pin.- 452002' }
    total_amount { 79990 }
    time_of_order { Time.current }
    time_of_delivery { Time.current + 5.days }
  end
end
