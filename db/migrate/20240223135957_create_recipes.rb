# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time, null: false
      t.integer :prep_time, null: false
      t.text :ingredients
      t.float :ratings
      t.string :cuisine, null: false
      t.string :category, null: false
      t.string :author, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
