require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = create(:user)    
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe_type2 = create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine, name: 'Brasileira')
    cuisine2 = create(:cuisine, name: 'Arabe')
    recipe = create(:recipe, title: 'Bolodecenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'
    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)    
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe_type2 = create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine, name: 'Brasileira')
    cuisine2 = create(:cuisine, name: 'Arabe')
    recipe = create(:recipe, title: 'Bolodecenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
