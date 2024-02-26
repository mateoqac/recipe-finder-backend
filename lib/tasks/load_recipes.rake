namespace :db do
  desc 'Load recipes from JSON file and save to the database'
  task load_recipes: :environment do
    json_data = File.read('public/recipes-en.json')
    recipes = JSON.parse(json_data)

    recipes.each do |recipe_data|
      Recipe.create!(
        title: recipe_data['title'],
        cook_time: recipe_data['cook_time'],
        prep_time: recipe_data['prep_time'],
        ingredients: recipe_data['ingredients'],
        ratings: recipe_data['ratings'],
        cuisine: recipe_data['cuisine'],
        category: recipe_data['category'],
        author: recipe_data['author'],
        image: recipe_data['image']
      )
    end

    puts 'Recipes loaded and saved successfully!'
  end
end
