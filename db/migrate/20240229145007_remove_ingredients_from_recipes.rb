# frozen_string_literal: true

class RemoveIngredientsFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :ingredients, :text, index: true
  end
end
