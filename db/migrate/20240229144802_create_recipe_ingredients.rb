# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.string :unit, null: false

      t.timestamps
    end
  end
end