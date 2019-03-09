class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_type = RecipeType.all
    @cuisine = Cuisine.all
  end

  def create
    @recipe = Recipe.new(params_recipe)
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
    @recipe = Recipe.find(params[:id])
    @recipe_type = RecipeType.all
    @cuisine = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id])    
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
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end

  def search
    @recipes = Recipe.where('title like ?', "%#{params[:search]}%")
    if @recipes.empty?
      flash[:alert] = 'Desculpe, não foi encontrado nenhum resultado para o termo pesquisado'
    end
  end

  private

  def params_recipe
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :photo)
  end
end