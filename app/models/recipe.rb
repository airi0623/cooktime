class Recipe < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  
  mount_uploader :image, ImageUploader

  belongs_to    :user
  has_many      :ingredients
  # has_many    :cooks
  # has_many    :comments
  # has_many    :adds

  with_options presence: true do
    validates :user_id
    validates :title
    validates :eat
    validates :category_id, numericality: { other_than: 1, message: "を選択してください" } 
    validates :time,        format: {with: /\d/}
  end
  validates :cold_date,   format: {with: /\d/}
  validates :frozen_date, format: {with: /\d/}
end
