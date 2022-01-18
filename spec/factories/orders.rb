FactoryBot.define do
  factory :order do
    association :user, factory: :user
    total { 9.99 }
  end
end
