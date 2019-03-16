class List < ApplicationRecord
  belongs_to :user

  has_many :list_recipes

  validates :name, presence: true
end
