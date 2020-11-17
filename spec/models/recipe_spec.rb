require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'recipes#create' do
    let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }
    
    before do
      user = FactoryBot.create(:user)  
      @recipe = FactoryBot.build(:recipe, user_id: user.id, images:[image])
      binding.pry
    end

    describe 'レシピ新規登録' do
      context '新規登録がうまくいくとき' do
        it "title、feature、eat、category_id、が存在すれば登録できること" do
          expect(@recipe).to be_valid
        end
      end

      context 'レシピ登録がうまくいかない時' do
        it "画像がないと登録ができない" do
          @recipe.images = [""]
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include('画像を入力してください')
        end
        it "レシピ名がないと登録できない" do
          @recipe.title = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("レシピタイトルを入力してください")
        end
        it "料理の特徴の情報がないと登録できない" do
          @recipe.feature = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("カテゴリーを選択してください")
        end
        it "食べ方の情報がないと登録できない" do
          @recipe.eat = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("食べ方を入力してください")
        end
        it "カテゴリーの情報がないと登録できない" do
          @recipe.category_id = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("カテゴリーを選択してください")
        end
        it "冷蔵庫の保存期間がないと登録できない" do
          @recipe.cold_date = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("冷蔵庫の保存期間を入力してください")
        end
        it "冷凍庫の保存期間がないと登録できない" do
          @recipe.frozen_date = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("冷凍庫の保存期間を入力してください")
        end
        it "調理時間の情報がないと登録できない" do
          @recipe.time = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("調理時間を入力してください")
        end
        it "作り方の情報がないと登録できない" do
          @recipe.text = nil 
          @recipe.valid?
          expect(@recipe.errors.full_messages).to include("作り方を入力してください")
        end
      end
    end
  end
end

