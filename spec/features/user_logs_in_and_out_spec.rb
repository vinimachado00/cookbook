require 'rails_helper'

feature 'User logs in' do
  scenario 'successfully' do
    user = create(:user)
  
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    # expectativas
    expect(page).to have_link('Sair')
    expect(page).to have_content("Bem-vindo, #{user.email}!")
  end

  scenario 'and logs out' do
    # cria os dados
    user = create(:user)
  
    # ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_on 'Sair'

    # expectativas
    within 'div.login_logout' do
      expect(page).to have_link('Entrar')
    end
    expect(page).not_to have_content("Bem-vindo, #{user.email}!")
  end
end