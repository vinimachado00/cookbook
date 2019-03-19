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
end