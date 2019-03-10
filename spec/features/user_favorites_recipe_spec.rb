require 'rails_helper'

feature 'User favorites recipe' do
  scenario 'successfully' do
    # cria os dados
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    favorite_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                    favorite: false)

    # ação do usuário
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Favoritar'

    # favorite_recipe = Recipe.find(favorite_recipe.id)
    favorite_recipe.reload
    # expectativas
    expect(page).to have_content('Receitas em destaque')
    within 'div.favoritas' do
      expect(page).to have_content('Bolo de cenoura')
      expect(page).to have_css('img[src*="star.png"]')
    end
    expect(current_path).to eq root_path
    expect(favorite_recipe.favorite).to eq true
  end

  scenario 'unfavorite' do
    # cria os dados
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  favorite: true)

    # ação do usuário
    visit recipe_path(recipe)
    click_on 'Desfavoritar'
    click_on 'Bolo de cenoura'

    # expectativas
    expect(page).not_to have_content('Desfavoritar')
    expect(page).to have_content('Favoritar')
  end
end