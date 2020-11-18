require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'ingredients#create' do
    # icon画像
    let(:icon_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:icon) { Rack::Test::UploadedFile.new(icon_path) }
    # レシピ画像
    let(:image_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
    let(:image) { Rack::Test::UploadedFile.new(image_path) }

    before do
      user = FactoryBot.create(:user, icon: icon)
      recipe = FactoryBot.create(:recipe, user_id: user.id, images:[image])
      @ingredient = FactoryBot.build(:ingredient, recipe_id: recipe.id)
    end
    describe '材料の登録' do
      context '材料登録がうまくいくとき' do
        it "recipe_id、amount、thing_idが存在すれば登録できること" do
          expect(@ingredient).to be_valid
        end
      end

      context '材料登録がうまくいかない時' do
        it "thing_idがないと登録ができない" do
          @ingredient.thing_id = nil
          @ingredient.valid?
          expect(@ingredient.errors.full_messages).to include("Thingを入力してください")
        end
        it "thing_idがないと登録ができない" do
          @ingredient.amount = nil
          @ingredient.valid?
          expect(@ingredient.errors.full_messages).to include("Amountを入力してください")
        end
      end
    end
  end
end
