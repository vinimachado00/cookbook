require 'rails_helper'

feature 'User creates list' do
  scenario 'successfully' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Adicionar lista de receitas'
    fill_in 'Nome', with: 'Almoço em família'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'Almoço em família')
  end

  scenario 'and name is mandatory' do
    user = create(:user)    

    login_as user, scope: :user
    visit root_path
    click_on 'Adicionar lista de receitas'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os campos!')
  end

  scenario 'and sees all lists' do
    user = create(:user)    
    list1 = create(:list, name: 'Almoço em família', user: user)
    list2 = create(:list, name: 'Café da tarde', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver minhas listas'

    expect(page).to have_css('p', text: 'Almoço em família')
    expect(page).to have_link('Café da tarde')
  end
end