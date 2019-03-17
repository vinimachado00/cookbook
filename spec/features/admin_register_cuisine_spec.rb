require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'Brasileira')
  end

  scenario 'and must fill in all fields' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não é possível cadastrar receita vazia')
  end
end