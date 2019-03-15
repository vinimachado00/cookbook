class List < ApplicationRecord
  belongs_to :user

  has_many :list_recipe

  validates :name, presence: true
end
