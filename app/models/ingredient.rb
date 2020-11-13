class Ingredient < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :thing

  belongs_to :recipe, optional: true, dependent: :destroy
  belongs_to :thing,  dependent: :destroy
  
  with_options presence: true do
    # validates :recipe_id
    # idをバリデーションに入れるとまだ発行されていないidのためエラーがでる
    validates :thing_id
    validates :amount, format: {with: /\d/}
  end
end
