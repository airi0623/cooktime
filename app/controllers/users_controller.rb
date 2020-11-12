class UsersController < ApplicationController
  before_action :check_guest, only: :edit

  def show
    @user = User.find(params[:id])
  end
  def profile
    @user = User.find(params[:id])
    @recipes = Recipe.where(user_id: @user.id)
  end
  def do_cook
    @ingredients = Ingredient.where(recipe_id: params[:id])
    @choices = Choice.where(user_id: current_user.id)
  end
  def my_recipe
    @recipes = Recipe.where(user_id: current_user.id).order("created_at DESC")
  end
  
end

