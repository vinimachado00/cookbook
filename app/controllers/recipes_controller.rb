# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update
                                              destroy favorite unfavorite]

  def index
    @recipes = Recipe.all
    @last_recipes = Recipe.last(6)
  end

  def show
    find_recipe_by_id
    @lists = List.all
  end

  def new
    @recipe = Recipe.new
    @recipe_type = RecipeType.all
    @cuisine = Cuisine.all
  end

  def create
    @recipe = Recipe.new(params_recipe)
    @recipe.favorite = false
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_type = RecipeType.all
      @cuisine = Cuisine.all
      render :new
    end
  end

  def edit
    find_recipe_by_id
    redirect_to root_path if user_signed_in? == false
    @recipe_type = RecipeType.all
    @cuisine = Cuisine.all
  end

  def update
    find_recipe_by_id
    if @recipe.update(params_recipe)
      redirect_to @recipe
    else
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_type = RecipeType.all
      @cuisine = Cuisine.all
      render :edit
    end
  end

  def destroy
    find_recipe_by_id
    @recipe.destroy
    redirect_to root_path
  end

  def search
    @recipes = Recipe.where('title like ?', "%#{params[:search]}%")
    if @recipes.empty?
      flash[:alert] = 'Desculpe, não foi encontrado nenhum resultado para o termo pesquisado'
    end
  end

  def favorite
    find_recipe_by_id
    @recipe.update(favorite: true)
    redirect_to root_path
  end

  def unfavorite
    find_recipe_by_id
    @recipe.update(favorite: false)
    redirect_to root_path
  end

  def all
    @recipes = Recipe.all
  end

  def my_recipes
    @recipes = current_user.recipes
  end

  def add_list
    @list = List.find(params[:list_id])
    @recipe = Recipe.find(params[:id])
    list_recipe = ListRecipe.new(list: @list, recipe: @recipe)
    if list_recipe.save
      flash[:alert] = "Adicionado à lista '#{list_recipe.list.name}' com sucesso!"
      redirect_to @recipe
    end
  end

  def my_favorite_recipes
    @recipes = current_user.recipes
  end

  private

  def params_recipe
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :photo, :favorite)
  end

  def find_recipe_by_id
    @recipe = Recipe.find(params[:id])
  end
end
