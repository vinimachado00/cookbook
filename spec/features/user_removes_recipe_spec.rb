require 'rails_helper'

feature 'User removes recipe' do
  scenario 'successfully' do
    # cria os dados
    user = User.create!(email: 'vinimachado00@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    
    Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                  cuisine: cuisine, difficulty: 'Difícil',
                  cook_time: 90,
                  ingredients: 'Feijão e carnes',
                  cook_method: 'Misture o feijão com as carnes', user: user)

    # ação do usuário
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Apagar receita'

    # expectativas
    expect(page).not_to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Feijoada')
  end
end