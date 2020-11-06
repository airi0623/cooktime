class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def do_cook
    @ingredients = Ingredient.where(recipe_id: params[:id])
    @choices = Choice.where(user_id: current_user.id)

    # @recipe = Recipe.find(params[:id])
    # @user = User.find(params[:id])
    # @recipes = Recipe.where(user_id: params[:id]).order("created_at DESC") 
  end
end

