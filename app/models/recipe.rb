class Recipe < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  # 材料のアソシエーション
  has_many      :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  # 画像のアソシエーション
  mount_uploaders :images, ImageUploader, dependent: :destroy
  serialize :images, JSON
  # その他アソシエーション
  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :users, through: :choices, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, dependent: :destroy
  
  # すでにいいねしたかどうかを判断するためのメソッド
  def choiced_by?(user)
    choices.where(user_id: user).exists?
  end

  def add_by?(user)
    likes.where(user_id: user).exists?
  end


  # has_many    :cooks
  # has_many    :comments

  # presence trueじゃないのにエラーでる。
  # validates :cold_date,   format: {with: /\d/}
  # validates :frozen_date, format: {with: /\d/}

  with_options presence: true do
    validates :user_id
    validates :title
    validates :eat
    validates :category_id, numericality: { other_than: 2, message: "を選択してください" } 
    validates :time,        format: {with: /\d/}
    validates :text
    validates :images
  end
end
