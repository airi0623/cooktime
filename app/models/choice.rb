class Choice < ApplicationRecord
  belongs_to :recipe, optional: true, dependent: :destroy
  belongs_to :user, optional: true, dependent: :destroy
  validates_uniqueness_of :recipe_id, scope: :user_id
end


