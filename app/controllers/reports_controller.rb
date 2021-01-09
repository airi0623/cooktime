class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    # ネストした時にIDが渡される形が〇〇_id
    @report = Report.new(repo_params)
    if @report.save
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:recipe_id])
    @reports = Report.where(recipe_id: @recipe.id)
  end

  private
  def repo_params
    params.require(:report).permit(:repo_image, :repo).merge( recipe_id: @recipe.id, user_id: current_user.id)
  end
end
