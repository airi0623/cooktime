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
      sign_in(@user)
      visit new_recipe_path
      #foem入力
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
      # DBに保存されていることを確認 → 投稿内容が表示されている
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(1)
      expect(current_path).to eq my_recipe_user_path(@user.id)
      expect(page).to have_content(@recipe.title)
    end
  end

  context 'レシピ新規登録に失敗するとき' do 
    it 'ログインしたユーザーがだだしい情報を入れなければ保存できない' do
      sign_in(@user)
      visit new_recipe_path
      # form入力
      fill_in "recipe-title", with: ""
      fill_in "recipe-feature", with: ""
      fill_in "recipe-eat", with: ""
      fill_in "recipe-cold-date", with: ""
      fill_in "recipe-frozen-date", with: ""
      fill_in "recipe-time", with: ""
      fill_in "ingredient-amount", with: ""
      fill_in "recipe-text", with: ""
      # select '0', from: 'recipe-category'
      # select '0', from: 'thing-select'
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
      expect(current_path).to eq "/recipes"
    end
  end
end

RSpec.describe 'レシピ編集', type: :system do
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    recipe_registration
    @user = FactoryBot.create(:user, icon: icon)
    @user2 = FactoryBot.create(:user, icon: icon)
    @recipe = FactoryBot.create(:recipe, user_id: @user.id)
    @ingredient = FactoryBot.create(:ingredient, recipe_id: @recipe.id)
  end

  context 'レシピの編集ができる時' do
    it 'ログインしたユーザーは自分のレシピ内容を編集できる' do
      sign_in(@user)
      visit user_path(@user.id)
      expect(page).to have_content("登録したレシピ")
      visit my_recipe_user_path(@user.id)
      expect(page).to have_content('投稿したレシピ')
      expect(page).to have_content('編集')
      visit edit_recipe_path(@recipe.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('#recipe-title').value).to eq @recipe.title
      expect(find('#recipe-feature').value).to eq @recipe.feature
      expect(find('#recipe-eat').value).to eq @recipe.eat
      expect(page).to have_select('recipe-category', selected: @recipe.category.name)
      expect(find('.recipes-cold-date').value).to eq @recipe.cold_date.to_s
      expect(find('.recipes-frozen-date').value).to eq @recipe.frozen_date.to_s
      expect(find('.recipes-time').value).to eq @recipe.time.to_s
      expect(page).to have_select('thing-select', selected: @ingredient.thing.thing_name)
      expect(find('#ingredient-amount').value.to_f).to eq @ingredient.amount
      expect(find('.recipes-text').value).to eq @recipe.text
      # 投稿内容を編集する
      fill_in 'recipe-title', with: 'レシピタイトルを変更'
      fill_in 'recipe-feature', with: '料理の特徴を変更'
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(0)
      expect(current_path).to eq my_recipe_user_path(@user.id)
      expect(page).to have_content('レシピタイトルを変更')
      expect(page).to have_content('料理の特徴を変更')
    end
  end

  context 'レシピの編集ができない時' do
    it 'ログインせずに編集ページへ飛ぶとログイン画面へ遷移する' do
      visit edit_recipe_path(@recipe.id)
      expect(current_path).to eq user_session_path
    end
  end

  context 'レシピの編集ができない時' do
    it 'レシピを作成したユーザーとcurrentユーザーが一致しないとroot_pathへ遷移する' do
      sign_in(@people)
      find('input[name="commit"]').click
      visit edit_recipe_path(@recipe.id)
      expect(current_path).to eq root_path
    end
  end
end
