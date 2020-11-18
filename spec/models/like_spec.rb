require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'like#create' do
    # icon画像
    let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
    # レシピ画像
    let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }
    
    before do
      user = FactoryBot.create(:user, icon: icon)
      recipe = FactoryBot.create(:recipe, user_id: user.id, images:[image])
      @like = FactoryBot.build(:like, user_id: user.id, recipe_id: recipe.id)
    end

    describe 'お気に入り新規登録' do
      context 'お気に入り登録がうまくいくとき' do
        it "user_id、recipe_idが存在すれば登録できること" do
          expect(@like).to be_valid
        end

        context 'お気に入り新規登録がうまくいかない時' do
          it "同じユーザーが同じレシピを2回お気に入り登録できない" do
            @like.save
            second_like = FactoryBot.build(:like, user_id: @like.user_id, recipe_id: @like.recipe_id)
            second_like.valid?
            expect(second_like.errors.full_messages).to include("Recipeはすでに存在します")
          end
        end
      end
    end
  end
end
