class Like < ApplicationRecord
  belongs_to :recipe,dependent: :destroy
  belongs_to :user
  validates_uniqueness_of :recipe_id, scope: :user_id
end
