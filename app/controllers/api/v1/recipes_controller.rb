# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      # before_action :load_recipes, only: %i[index find]

      def index
        @recipes = Recipe.paginate(page: params[:page], per_page: default_per_page)
        render json: { data: @recipes,
                       meta: { total_pages: @recipes.total_pages, current_page: @recipes.current_page } }
      end

      def find
        query = user_input_ingredients.map do
          'recipes.ingredients ILIKE ?'
        end.join(' AND ')
        pattern = user_input_ingredients.map { |ingredient| "%#{ingredient}%" }

        @matching_recipes = Recipe
                            .where(query, *pattern)
                            .order(ratings: :desc)
                            .paginate(page: params[:page], per_page: default_per_page)

        render json: { data: @matching_recipes,
                       meta: { total_pages: @matching_recipes.total_pages,
                               current_page: @matching_recipes.current_page } }
      end

      private

      def default_per_page
        params[:per_page] || 12
      end

      def user_input_ingredients
        params[:ingredient].to_s.downcase.strip.split(',').map(&:strip)
      end
    end
  end
end
