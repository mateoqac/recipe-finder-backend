# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :cook_time, :prep_time, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :ratings, :category, :author, presence: true

  def as_json(options = {})
    RecipeSerializer.new(self, options).as_json
  end
end
