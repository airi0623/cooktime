
require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  # icon画像
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  # レシピ画像
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  
  before do
    password = 'aaaa0000'
    people = FactoryBot.create(:user, icon: icon, password: password, password_confirmation: password)
    recipe1 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe2 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe3 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    likes1 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe1.id)
    likes2 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe2.id)
    likes3 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe3.id)

    @ranking = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
    @user = FactoryBot.build(:user, icon: icon)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      #新規登録ページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      attach_file('user[icon]', icon_path, make_visible: true)
      fill_in 'user-nickname', with: @user.nickname
      fill_in 'user-profile', with: @user.profile
      fill_in 'user-family', with: @user.family_name
      fill_in 'user-first', with: @user.first_name
      fill_in 'user-email', with: @user.email
      fill_in 'user-password', with: @user.password
      fill_in 'user-password-confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      visit  root_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user-nickname', with: ""
      fill_in 'user-profile', with: ""
      fill_in 'user-family', with: ""
      fill_in 'user-first', with: ""
      fill_in 'user-email', with: ""
      fill_in 'user-password', with: ""
      fill_in 'user-password-confirmation', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  
  before do
    password = 'aaaa0000'
    people = FactoryBot.create(:user, icon: icon, password: password, password_confirmation: password)
    recipe1 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe2 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe3 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    likes1 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe1.id)
    likes2 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe2.id)
    likes3 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe3.id)

    @ranking = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
    @user = FactoryBot.create(:user, icon: icon)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user-email', with: @user.email
      fill_in 'user-password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されている
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit user_session_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user-email',  with: ""
      fill_in 'user-password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end