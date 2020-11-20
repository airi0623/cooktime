
require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    recipe_registration
    @ranking = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
    @user = FactoryBot.build(:user, icon: icon)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # ユーザーを新規登録する
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
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
    recipe_registration
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
      sign_in(@user)
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

RSpec.describe 'ユーザー編集', type: :system do
  let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
  let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  
  before do
    recipe_registration
    @user = FactoryBot.create(:user, icon: icon)
    @ranking = Recipe.all.sort {|a,b| b.likes.count <=> a.likes.count}
  end
  context 'ユーザー編集ができる時' do
    it 'ログインしたユーザーは自分の個人情報を編集できる' do
      sign_in(@user)
      visit user_path(@user.id)
      expect(page).to have_content("登録情報編集")
      visit edit_user_registration_path
      expect(page).to have_content('会員情報編集')
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#user-nickname').value
      ).to eq @user.nickname
      expect(
        find('#user-profile').value
      ).to eq @user.profile
      expect(
        find('.users-family-name').value
      ).to eq @user.family_name
      expect(
        find('.users-first-name').value
      ).to eq @user.first_name
      expect(
        find('#user-email').value
      ).to eq @user.email
      # 投稿内容を編集する
      fill_in 'user-nickname', with: '登録内容を変更'
      fill_in 'user-profile', with: '登録内容を変更しました'
      fill_in 'user-password', with: @user.password
      fill_in 'user-current_password', with: @user.password
      fill_in 'user-password-confirmation', with: @user.password
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      expect(current_path).to eq root_path
      visit user_path(@user.id)
      expect(page).to have_content('登録内容を変更')
      expect(page).to have_content('登録内容を変更しました')
    end
  end
end