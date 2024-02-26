# frozen_string_literal: true

class AddFullTextIndexToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_index :recipes, :ingredients, using: :gin, opclass: :gin_trgm_ops, name: 'ingredients_search_index'
  end
end
