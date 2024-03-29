# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        @recipes = Recipe.paginate(page: params[:page], per_page: default_per_page)
        render json: { data: @recipes,
                       meta: { total_pages: @recipes.total_pages, current_page: @recipes.current_page } }
      end

      def find
        @matching_recipes = Recipe.joins(:recipe_ingredients)
                                  .select('recipes.*, COUNT(recipe_ingredients.id) AS ingredient_count')
                                  .where(recipe_ingredients: { ingredient_id: matching_ingredient_ids })
                                  .group('recipes.id')
                                  .order('ingredient_count DESC', 'recipes.ratings DESC')
                                  .paginate(page: params[:page], per_page: default_per_page)
        render json: { data: @matching_recipes,
                       meta: { total_pages: @matching_recipes.total_pages,
                               current_page: @matching_recipes.current_page } }
      end

      private

      def matching_ingredient_ids
        Ingredient.where('LOWER(ingredients.name) ILIKE ANY (array[?])', user_input_ingredients.map do |ingredient|
                                                                           "%#{ingredient.downcase}%"
                                                                         end).pluck(:id)
      end

      def default_per_page
        params[:per_page] || 12
      end

      def user_input_ingredients
        params[:ingredient].to_s.downcase.strip.split(',').map(&:strip)
      end
    end
  end
end
