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
end