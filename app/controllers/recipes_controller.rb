class RecipesController < ApplicationController
  before_action :search_recipe, only:[:index, :search,:search_result, :more]
  
  def about
  end

  def index
    @recipes = Recipe.all.order("created_at DESC").limit(12)
    @ranking = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
  end

  def new
    authenticate_user!
    @recipe = Recipe.new # @recipe.images.build  # recipeに紐付けた状態でimageを作成
    @ingredient = @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params) 
    if @recipe.save
      redirect_to my_recipe_user_path(id: current_user) # redirect先で必要なidを入れる
    else
      render :new
    end
  end

  def show
    @ingredients = Ingredient.where(recipe_id: params[:id])
    @recipe = Recipe.find(params[:id])
    @user = User.find(@recipe.user_id)
    # binding.pry
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.where(recipe_id: params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.where(user_id: current_user.id).order("created_at DESC")
    if @recipe.update(recipe_params)
      redirect_to my_recipe_user_path(id: current_user)
    else
      render :edit
    end
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

  def search_result
  end

  def shoplist
    @ingredients = {}
    params[:ingredient].each do |id, ingredient|
      # ↑paramsのingredientの箱に入っているから
      require 'bigdecimal'
      total = ingredient.map(&:to_f).sum
      name  = Thing.find(id).thing_name
    
      @ingredients[id] = total
      # @ingredients => {"豚肉バラ"=>2, "きゅうり"=>2}
      # name => "豚肉バラ"
      # total => 800
      # id => "12"
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(
      {images: []},:title,:feature,:eat,:category_id,:cold_date,:frozen_date,:time,:text,
      ingredients_attributes:[:id, :recipe_id, :thing_id, :amount, :_destroy])
      .merge(user_id: current_user.id)
  end

  def search_recipe
    @p = Recipe.ransack(params[:q])  # 検索オブジェクトを生成
    @results = @p.result
  end
end
