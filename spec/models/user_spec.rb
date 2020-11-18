require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'users#create' do
    let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:icon) { Rack::Test::UploadedFile.new(icon_path) }

    before do
      @user = FactoryBot.build(:user, icon: icon)
    end
    
    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it "nickname、email、姓、名、password、password_confirmationが存在すれば登録できること" do
          expect(@user).to be_valid
        end
        it "passwordが6文字以上の英数字であれば登録できること" do
          @user.password = "aaaa000"
          @user.password_confirmation ="aaaa000"
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        # ニックネーム ---------------------
        it "nicknameが空では登録できないこと" do
          @user.nickname = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームを入力してください")
        end
        #email ---------------------
        it "emailが空では登録できないこと" do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end
        it "emailが＠がなければ登録できないこと" do
          @user.email = "dddddgmail.com"
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールは不正な値です")
        end
        it "重複したemailが存在する場合登録できないこと" do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email, icon: icon)
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
        end
        # Password ---------------------
        it "passwordが空では登録できないこと" do
          @user.password = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end
        it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end
        it "passwordが5文字以下の英数字であれば登録できないこと" do
          @user.password = "aa000"
          @user.password_confirmation ="aa000"
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
        end
        it "passwordが6文字以上でも英数字を含まなければ登録できないこと" do
          @user.password = "000000"
          @user.password_confirmation ="000000"
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは英数字で入力してください")
        end
        it "passwordが6文字以上でも英数字を含まなければ登録できないこと" do
          @user.password = "aaaaaa"
          @user.password_confirmation ="aaaaaa"
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは英数字で入力してください")
        end
        # お名前全角:姓 ---------------------
        it  "お名前(全角):苗字が空では登録できないこと" do
          @user.family_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角(漢字・平仮名)で入力してください")
        end
        it  "お名前(全角):苗字が日本語全角でないとは登録できないこと" do
          @user.family_name = "kana"
          @user.valid?
          expect(@user.errors.full_messages).to include("苗字は全角(漢字・平仮名)で入力してください")
        end
        # お名前全角:名 ---------------------
        it  "お名前(全角):名前が空では登録できないこと" do
          @user.first_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角(漢字・平仮名)で入力してください")
        end
        it  "お名前(全角):名前が日本語全角でないとは登録できないこと" do
          @user.first_name = "kana"
          @user.valid?
          expect(@user.errors.full_messages).to include("名前は全角(漢字・平仮名)で入力してください")
        end
      end
    end
  end
end

