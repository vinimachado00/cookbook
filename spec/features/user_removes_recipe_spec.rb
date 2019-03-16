require 'rails_helper'

feature 'User removes recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    another_recipe_type = create(:recipe_type, name: 'Prato principal')
    create(:recipe, user: user)
    create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
           cook_time: 90, ingredients: 'Feijão e carnes',
           cook_method: 'Misture o feijão com as carnes', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Apagar receita'

    expect(page).not_to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Feijoada')
  end
end