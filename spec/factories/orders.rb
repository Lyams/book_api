FactoryBot.define do
  factory :order do
    association :user, factory: :user
    total { 0.00 }
  end
end
