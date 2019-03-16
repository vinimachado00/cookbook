FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "vinimachado00#{n}@gmail.com" }
    password { '123456' }
  end
end