class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  has_one_attached :photo

  validates :title, :difficulty, :recipe_type, :cuisine,
            :cook_time, :ingredients, :cook_method, presence: true
end
