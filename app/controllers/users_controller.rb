class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(params[:id])
    @recipes = Recipe.where(user_id: @user.id)
  end
end
