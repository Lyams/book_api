# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { 'TV LG' }
    price { 14_000.00 }
    published { false }
    quantity { 5 }
    association :user, factory: :user
  end
  factory :product_keda, class: :product do
    title { 'Kedi novie kak po tv' }
    price { 5000.00 }
    published { false }
    quantity { 7 }
    association :user, factory: :user2
  end
end
