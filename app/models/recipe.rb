class Recipe < ApplicationRecord
  validates :title, :difficulty, :recipe_type, :cuisine,
            :cook_time, :ingredients, :cook_method, presence: true
end
