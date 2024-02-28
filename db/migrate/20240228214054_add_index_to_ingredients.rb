# frozen_string_literal: true

class AddIndexToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_index :recipes, :ingredients, using: :gin, opclass: :gin_trgm_ops
  end
end
