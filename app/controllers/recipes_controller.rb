class RecipesController < ApplicationController
  def about
  end

  def index
    @recipes = Recipe.all.order("created_at DESC").limit(12)
  end

  def about
  end

  def new
    authenticate_user!
    @recipe = Recipe.new
    # @recipe.images.build  # recipeに紐付けた状態でimageを作成
    @ingredient = @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # binding.pry
    #@user = User.find(current_user.id)
    #@ingredient = @recipe.ingredients
    if @recipe.save
      redirect_to user_path(id: current_user)
      # redirect先で必要なidがなかったのが原因??
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
    @ingredients = Ingredient.where(recipe_id: params[:id])
  end

  def edit
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @ingredients =Ingredient.where(recipe_id: @recipe.id)
    @choice = Choice.where(recipe_id: @recipe.id)
    if @recipe.destroy
      redirect_to my_recipe_user_path(current_user.id)
    else
      redirect_to user_path(current_user.id)
    end
  end

  def more
    @recipes = Recipe.all.order("created_at DESC")
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      {images: []},:title,:feature,:eat,:category_id,:cold_date,:frozen_date,:time,:text,
      ingredients_attributes:[:id, :recipe_id, :thing_id, :amount, :_destroy])
      .merge(user_id: current_user.id)
  end
end
