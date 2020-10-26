class Ingredient < ApplicationRecord
  belongs_to    :recipe
  belongs_to    :thing

  with_options presence: true do
    validates :recipe_id
    validates :thing_id
    validates :amount, format: {with: /\d/}
  end
end
