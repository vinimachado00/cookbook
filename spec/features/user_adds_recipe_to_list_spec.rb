require 'rails_helper'

feature 'User adds recipe to list' do
  scenario 'successfully' do
    user = create(:user)
    list = create(:list, user: user)
    random_list = create(:random_list, user: user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    favorite_recipe = create(:recipe)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    select 'Café da tarde', from: 'Lista'
    click_on 'Adicionar à esta lista'
    
    expect(page).to have_content("Adicionado à lista '#{list.name}' com sucesso!")
  end

  scenario 'and sees recipes saved through lists' do
    user = create(:user)
    list = create(:list, user: user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    favorite_recipe = create(:recipe)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    select list.name, from: 'Lista'
    click_on 'Adicionar à esta lista'
    visit my_lists_path
    click_on list.name
    
    expect(page).to have_content(favorite_recipe.title)
  end
end