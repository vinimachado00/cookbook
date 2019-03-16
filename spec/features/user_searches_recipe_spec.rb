require 'rails_helper'

feature 'User searches recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    another_recipe_type = create(:recipe_type, name: 'Prato principal')
    create(:recipe, user: user)
    create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
           cook_time: 90, ingredients: 'Feijão e carnes',
           cook_method: 'Misture o feijão com as carnes', user: user)
    
    visit root_path
    fill_in 'Pesquisar', with: 'Bolo de cenoura'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h1', text: 'Feijoada')
  end

  scenario 'partially' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    create(:recipe, ingredients: 'Farinha, açucar, cenoura',
           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', 
           user: user)
    
    create(:recipe, title: 'Bolo de chocolate', ingredients: 'Farinha, açucar e chocolate',
           cook_method: 'Faça o chocolate e misture com o resto dos ingredientes', 
           user: user)
    
    visit root_path
    fill_in 'Pesquisar', with: 'bolo'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de chocolate')
  end

  scenario 'and must fill in all fields' do
    visit root_path
    fill_in 'Pesquisar', with: ''
    click_on 'Buscar'

    expect(page).to have_content('Desculpe, não foi encontrado nenhum resultado para o termo pesquisado')
  end
end