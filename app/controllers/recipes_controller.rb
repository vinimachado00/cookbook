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
    @recipe = Recipe.new(params_recipe)
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end      
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])    
    if @recipe.update(params_recipe)
      redirect_to @recipe
    else
      flash[:alert] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def params_recipe
    params.require(:recipe).permit(:title, :recipe_type, :cuisine,
                                   :difficulty, :cook_time,
                                   :ingredients, :cook_method)
  end
end