class LikesController < ApplicationController
  def index
    @recipes = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
  end

  def create
    user = current_user.id
    @recipe = Recipe.find(params[:recipe_id])
    Like.create!(user_id: user, recipe_id: @recipe.id)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])  
    like= Like.find_by(user_id: current_user.id, recipe_id: @recipe.id )
    like.delete
  end
end
