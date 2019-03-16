FactoryBot.define do
  factory :list do
    name { 'Café da tarde' }
    user
  end

  factory :random_list, class: List do
    name { Faker::Name.name }
    user
  end
end