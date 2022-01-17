FactoryBot.define do
  factory :user do
    email {"aaa@aaa.com"}
    password {"1234567aBc"}
    password_confirmation {"1234567aBc"}
  end
  factory :user2, class: :user  do
    email {"bbb@bbb.com"}
    password {"MillionAlih1000000"}
    password_confirmation {"MillionAlih1000000"}
  end
end