require 'rails_helper'

feature 'User creates list' do
  scenario 'successfully' do
    user = User.create!(email: 'vinimachado00@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Adicionar lista de receitas'
    fill_in 'Nome', with: 'Almoço em família'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'Almoço em família')
  end

  scenario 'and name is mandatory' do
    user = User.create!(email: 'vinimachado00@gmail.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Adicionar lista de receitas'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os campos!')
  end

  scenario 'and sees all lists' do
    user = User.create!(email: 'vinimachado00@gmail.com', password: '123456')
    List.create(name: 'Almoço em família', user: user)
    List.create(name: 'Café da tarde', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver todas as listas'

    expect(page).to have_css('p', text: 'Almoço em família')
    expect(page).to have_css('p', text: 'Café da tarde')
  end
end