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
  def new_guest
    user = User.find_or_create_by!(email: 'guest@gmail.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "かんたんログイン"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private
  def check_guest
    if resource.email == 'guest@gmail.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end
end

