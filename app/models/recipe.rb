class Recipe < ApplicationRecord
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category

  mount_uploader :image, ImageUploader
  belongs_to    :user
  has_many      :ingredients, dependent: :destroy
  
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  # has_many    :cooks
  # has_many    :comments
  # has_many    :adds

  
  # presence trueじゃないのにエラーでる。
  # validates :cold_date,   format: {with: /\d/}
  # validates :frozen_date, format: {with: /\d/}

  with_options presence: true do
    validates :user_id
    validates :title
    validates :eat
    validates :category_id, numericality: { other_than: 1, message: "を選択してください" } 
    validates :time,        format: {with: /\d/}
    #ingredientsバリデーション 
    validates :recipe_id
    validates :thing_id
    validates :amount, format: {with: /\d/}
  end
end
