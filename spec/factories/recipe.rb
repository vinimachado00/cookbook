FactoryBot.define do
  factory :recipe do
    title { "Bolo de cenoura" }
    difficulty { "Médio" }
    recipe_type
    cuisine
    cook_time { 50 }
    ingredients { "Farinha, açucar, cenoura" }
    cook_method { "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes" }
    favorite { false }
    user
  end

  factory :random_recipe, class: Recipe do
    title { Faker::Food.dish }
    difficulty { Faker::String.random }
    recipe_type
    cuisine
    cook_time { Faker::String.random }
    ingredients { Faker::Food.ingredient }
    cook_method { Faker::Food.description }
    favorite { false }
    user
  end
end