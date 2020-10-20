class RecipesController < ApplicationController

  def index
  end

  def new
    authenticate_user!
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    # binding.pry
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #binding.pry
    #@user = User.find(current_user.id)
    #@ingredient = @recipe.ingredients
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
      :image,:title,:feature,:eat,:category_id,:cold_date,:frozen_date,:time,:text,
      ingredients_attributes:[:id, :recipe_id, :thing_id, :amount, :_destroy])
      .merge(user_id: current_user.id)
  end
end
