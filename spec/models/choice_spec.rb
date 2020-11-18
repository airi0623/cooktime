require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'choice#create' do
    # icon画像
    let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
    # レシピ画像
    let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }
    
    before do
      user = FactoryBot.create(:user, icon: icon)
      recipe = FactoryBot.create(:recipe, user_id: user.id, images:[image])
      @choice = FactoryBot.build(:like, user_id: user.id, recipe_id: recipe.id)
    end

    describe 'レシピ選択' do
      context 'レシピ選択がうまくいくとき' do
        it "user_id、recipe_idが存在すれば登録できること" do
          expect(@choice).to be_valid
        end

        context 'レシピ選択がうまくいかない時' do
          it "同じユーザーが同じレシピを2回選択できない" do
            @choice.save
            second_choice = FactoryBot.build(:like, user_id: @choice.user_id, recipe_id: @choice.recipe_id)
            second_choice.valid?
            expect(second_choice.errors.full_messages).to include("Recipeはすでに存在します")
          end
        end
      end
    end
  end
end
