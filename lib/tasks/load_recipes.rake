# frozen_string_literal: true

require 'debug'

JSON_FILE_PATH = 'public/recipes-en.json'
OUNCE_PATTERN = /\((\d+\s*[^\)]+)\)/
FULL_PATTERN = /(\d*\s*[½¼¾⅔⅝⅓⅛⅕⅖⅗⅘⅙⅚⅞⅐⅑⅒]|\d*)?\s*(\b\w+\b)?\s*(.*)/
NUMBER_PATTERN = /^\d|^[½¼¾⅔⅝⅓⅛⅕⅖⅗⅘⅙⅚⅞⅐⅑⅒]/

namespace :db do
  desc 'Load recipes from JSON file and save to the database'
  task load_recipes: :environment do
    Rake::Task['db:reset'].invoke
    Rake::Task['db:migrate'].invoke
    json_data = File.read(JSON_FILE_PATH)
    recipes = JSON.parse(json_data)
    errors = []
    threads = []
    max_threads = 10 # Set your desired maximum number of threads

    recipes.each_slice(max_threads) do |recipe_slice|
      recipe_slice.each do |recipe_data|
        threads << Thread.new do
          ActiveRecord::Base.connection_pool.with_connection do
            ingredients_data = recipe_data['ingredients']

            recipe = Recipe.create!(
              title: recipe_data['title'],
              cook_time: recipe_data['cook_time'],
              prep_time: recipe_data['prep_time'],
              ratings: recipe_data['ratings'],
              cuisine: recipe_data['cuisine'].empty? ? 'Unknown Cuisine' : recipe_data['cuisine'],
              category: recipe_data['category'].empty? ? 'Unknown Category' : recipe_data['category'],
              author: recipe_data['author'].empty? ? 'Unknown Author' : recipe_data['author'],
              image: recipe_data['image']
            )

            ingredients_data.each do |ingredient|
              quantity, unit, name = parse_ingredient(ingredient)

              ingredient = Ingredient.find_or_create_by(name:)
              recipe_ingredient = RecipeIngredient.new(
                recipe:,
                ingredient:,
                quantity:,
                unit:
              )
              if recipe_ingredient.valid?
                recipe_ingredient.save
              else
                errors << [recipe_data, ingredient]
                raise ActiveRecord::Rollback
              end
            end
          end
        end
      end

      threads.each(&:join)
      threads = []
    end

    puts "We couldn't proccess some data: #{errors}" unless errors.empty?
    puts 'Recipes loaded and saved successfully!'
  end
end

class ParseError < StandardError
end

def parse_ingredient(ingredient)
  return ['', '', ingredient] unless ingredient.match?(NUMBER_PATTERN)

  cleaned_text = ingredient
  if (match_ounces = ingredient.match(OUNCE_PATTERN))
    content_parentheses = match_ounces[0]
    cleaned_text = cleaned_text.gsub(/\(\d+\s*[^\)]+\)/, '')

  end

  match = cleaned_text.match(FULL_PATTERN)
  raise ParseError unless match

  quantity = "#{match[1]} #{content_parentheses}".strip

  if match[3].to_s.empty?
    rest = match[2]
    unit = ''
  else
    unit = match[2]
    rest = match[3]
  end

  [quantity, unit, rest]
end
