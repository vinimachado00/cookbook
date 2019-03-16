require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user)
    another_recipe_type = create(:recipe_type, name: 'Prato principal')
    another_recipe = create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
                            difficulty: 'Difícil', cook_time: 90, 
                            ingredients: 'Feijão e carnes',
                            cook_method: 'Misture o feijão com as carnes',
                            user: user)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and clicks to see all recipes' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user, favorite: true)
    another_recipe_type = create(:recipe_type, name: 'Prato principal')
    another_recipe = create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
                            difficulty: 'Difícil', cook_time: 90, 
                            ingredients: 'Feijão e carnes',
                            cook_method: 'Misture o feijão com as carnes',
                            user: user, favorite: false)
    
    visit root_path
    click_on 'Ver todas as receitas'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and views his recipes' do
    user = create(:user)
    user1 = create(:random_user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    another_recipe_type = create(:recipe_type, name: 'Prato principal')
    recipe = create(:recipe, favorite: true, user: user)
    another_recipe = create(:recipe, title: 'Feijoada', recipe_type: another_recipe_type,
                            difficulty: 'Difícil', cook_time: 90, 
                            ingredients: 'Feijão e carnes',
                            cook_method: 'Misture o feijão com as carnes',
                            user: user1, favorite: false)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver minhas receitas'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end
end
