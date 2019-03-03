class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(params_recipe)
    redirect_to @recipe
  end

  private

  def params_recipe
    params.require(:recipe).permit(:title, :recipe_type, :cuisine,
                                   :difficulty, :cook_time,
                                   :ingredients, :cook_method)
  end
end