require 'rails_helper'

feature 'User visit other users' do
  scenario 'successfully' do
    user1 = create(:random_user)
    user2 = create(:user)
    recipe1 = create(:recipe, user: user2)
    recipe2 = create(:random_recipe, user: user2)

    login_as user1, scope: :user
    visit root_path
    click_on recipe2.title
    click_on user2.email

    expect(page).to have_css('h2', text: user2.name)
    expect(page).to have_css('h2', text: user2.city)
    expect(page).to have_css('li', text: recipe1.title)
    expect(page).to have_css('li', text: recipe2.title)
  end

  xscenario 'and access recipe' do
    user1 = create(:random_user)
    user2 = create(:user)
    recipe1 = create(:recipe, user: user2)

    login_as user1, scope: :user
    visit user_path(user2)
    click_on recipe1.title

    expect(current_path).to eq recipe_path(recipe1)
    expect(page).to have_css('h1', text: recipe1.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe1.recipe_type.name)
    expect(page).to have_css('p', text: recipe1.cuisine.name)
    expect(page).to have_css('p', text: recipe1.difficulty)
    expect(page).to have_css('p', text: "#{recipe1.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe1.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe1.cook_method)    
  end

  scenario 'and must be logged in' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit user_path(user)

    expect(current_path).to eq new_user_session_path
  end
end