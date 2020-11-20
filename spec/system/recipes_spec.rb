require 'rails_helper'

RSpec.describe 'レシピ新規登録', type: :system do
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    recipe_registration
    @user = FactoryBot.create(:user, icon: icon)
    @recipe = FactoryBot.build(:recipe, user_id: @user.id)
    @ingredient = FactoryBot.build(:ingredient, recipe_id: @recipe.id)
  end

  context 'レシピ新規登録に成功するとき' do 
    it 'ログインしたユーザーが正しい情報を入力すればレシピ新規登録ができてマイページに移動する' do
      # サインインする
      sign_in(@user)
      # レシピ投稿ページへ移動する
      visit new_recipe_path
      # フォームに入力する
      attach_file('recipe[images][]', image_path, make_visible: true)
      fill_in "recipe-title", with: @recipe.title
      fill_in "recipe-feature", with: @recipe.feature
      fill_in "recipe-eat", with: @recipe.eat
      select '主菜', from: 'recipe-category'
      fill_in "recipe-cold-date", with: @recipe.cold_date
      fill_in "recipe-frozen-date", with: @recipe.frozen_date
      fill_in "recipe-time", with: @recipe.time
      select 'にんじん', from: 'thing-select'
      fill_in "ingredient-amount", with: @ingredient.amount
      fill_in "recipe-text", with: @recipe.text

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(1)
      # マイページの投稿したレシピページにいる
      expect(current_path).to eq my_recipe_user_path(@user.id)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@recipe.title)
    end
  end

  context 'レシピ新規登録に失敗するとき' do 
    it 'ログインしたユーザーがだだしい情報を入れなければ保存できない' do
      # サインインする
      sign_in(@user)
      visit new_recipe_path
      # form入力
      fill_in "recipe-title", with: ""
      fill_in "recipe-feature", with: ""
      fill_in "recipe-eat", with: ""
      # select '0', from: 'recipe-category'
      fill_in "recipe-cold-date", with: ""
      fill_in "recipe-frozen-date", with: ""
      fill_in "recipe-time", with: ""
      # select '0', from: 'thing-select'
      fill_in "ingredient-amount", with: ""
      fill_in "recipe-text", with: ""
      find('input[name="commit"]').click
      expect(current_path).to eq "/recipes"
    end

    it 'ログインしていないユーザーがレシピページに訪れる' do
      visit new_recipe_path
      expect(current_path).to eq new_user_session_path
    end

    it '【画像】登録情報に漏れがあれば投稿できない' do
      visit new_recipe_path
      expect(current_path).to eq new_user_session_path
      sign_in(@user)
      visit new_recipe_path
      # fome入力
      fill_in "recipe-title", with: @recipe.title
      fill_in "recipe-feature", with: @recipe.feature
      fill_in "recipe-eat", with: @recipe.eat
      select '主菜', from: 'recipe-category'
      fill_in "recipe-cold-date", with: @recipe.cold_date
      fill_in "recipe-frozen-date", with: @recipe.frozen_date
      fill_in "recipe-time", with: @recipe.time
      select 'にんじん', from: 'thing-select'
      fill_in "ingredient-amount", with: @ingredient.amount
      fill_in "recipe-text", with: @recipe.text
      find('input[name="commit"]').click
      # マイページの投稿したレシピページにいる
      expect(current_path).to eq "/recipes"
    end
  end
end