class RecipesController < ApplicationController

  def index
  end

  def new
    authenticate_user!
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @user = User.find(current_user.id)
    if @recipe.save
      redirect_to user_path(id: current_user)
      # redirect先で必要なidがなかったのが原因??
    else
      render :new
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      :image,:title,:feature,:eat,:category_id,:cold_date,
      :frozen_date,:time,:text).merge(user_id: current_user.id)
  end

end
