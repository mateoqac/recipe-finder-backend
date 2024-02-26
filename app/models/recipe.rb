# frozen_string_literal: true

class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :cook_time, :prep_time, numericality: { greater_than_or_equal_to: 0 }
  attribute :ingredients, :string, array: true, default: []
end
