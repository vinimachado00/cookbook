# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :authenticate_user!

  def my_lists
    @lists = current_user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params.require(:list).permit(:name))
    @list.user = current_user
    if @list.save
      redirect_to @list
    else
      flash[:alert] = 'É necessário preencher todos os campos!'
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def list_recipes
    @list_recipes = ListRecipe.all
  end
end
