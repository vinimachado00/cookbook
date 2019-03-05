class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine

  validates :title, :difficulty, :recipe_type, :cuisine,
            :cook_time, :ingredients, :cook_method, presence: true
end
