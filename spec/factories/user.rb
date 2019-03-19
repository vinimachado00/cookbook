FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "vinimachado00#{n}@gmail.com" }
    password { '123456' }
    name { 'vini' }
    city { 'SP' }
  end

  factory :random_user, class: User do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    city { Faker::String.random }
    password { '123456' }
  end
end