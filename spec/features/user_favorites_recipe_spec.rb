require 'rails_helper'

feature 'User favorites recipe' do
  scenario 'successfully' do
    user = create(:user)    
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe_type2 = create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine, name: 'Brasileira')
    cuisine2 = create(:cuisine, name: 'Arabe')
    favorite_recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user, favorite: false)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Favoritar'
    favorite_recipe.reload
    
    expect(page).to have_content('Receitas em destaque')
    within 'div.favoritas' do
      expect(page).to have_content('Bolo de cenoura')
      expect(page).to have_css('img[src*="star.png"]')
    end
    expect(current_path).to eq root_path
    expect(favorite_recipe.favorite).to eq true
  end

  scenario 'unfavorite' do
    user = create(:user)    
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe_type2 = create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine, name: 'Brasileira')
    cuisine2 = create(:cuisine, name: 'Arabe')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user, favorite: true)
    
    login_as user, scope: :user
    visit recipe_path(recipe)
    click_on 'Desfavoritar'
    click_on 'Bolo de cenoura'

    expect(page).not_to have_content('Desfavoritar')
    expect(page).to have_content('Favoritar')
  end

  scenario 'and view his favorite recipe' do
    user = create(:user)
    recipe1 = create(:recipe, user: user, favorite: true )
    recipe2 = create(:recipe, title: 'Feijoada', user: user, favorite: false)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ver minhas receitas favoritas'
    
    expect(page).to have_link(recipe1.title)
    expect(page).not_to have_content(recipe2.title)
  end

  scenario 'and view all his favorite recipes' do
    user = create(:user)
    recipe1 = create(:recipe, user: user, favorite: true )
    recipe2 = create(:recipe, title: 'Feijoada', user: user, favorite: true)
    recipe3 = create(:recipe, title: 'Churrasco', user: user, favorite: false)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ver minhas receitas favoritas'
    
    expect(page).to have_link(recipe1.title)
    expect(page).to have_link(recipe2.title)
    expect(page).not_to have_content(recipe3.title)
  end
end