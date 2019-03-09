require 'rails_helper'

feature 'User searches recipe' do
  scenario 'successfully' do
    # cria os dados
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                  cuisine: cuisine, difficulty: 'Difícil',
                  cook_time: 90,
                  ingredients: 'Feijão e carnes',
                  cook_method: 'Misture o feijão com as carnes')
    
    # ação do usuário
    visit root_path
    fill_in 'Pesquisar', with: 'Bolo de cenoura'
    click_on 'Buscar'

    # expectativas
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h1', text: 'Feijoada')
  end

  scenario 'partially' do
    # cria os dados
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Difícil',
                  cook_time: 50,
                  ingredients: 'Farinha, açucar e chocolate',
                  cook_method: 'Faça o chocolate e misture com o resto dos ingredientes')

    # ação do usuário
    visit root_path
    fill_in 'Pesquisar', with: 'bolo'
    click_on 'Buscar'

    # expectativas
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de chocolate')
  end

  scenario 'and must fill in all fields' do
    # ação do usuário
    visit root_path
    fill_in 'Pesquisar', with: ''
    click_on 'Buscar'

    expect(page).to have_content('Desculpe, não foi encontrado nenhum resultado para o termo pesquisado')
  end
end