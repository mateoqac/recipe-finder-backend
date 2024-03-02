# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :request do
  describe 'GET #index' do
    before do
      create_list(:recipe, 15)
    end

    it 'returns a successful response' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['data'].count).to eq(12)
    end

    it 'returns paginated results' do
      get '/?page=2'
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['data'].count).to eq(3)
    end
  end

  describe 'POST #find' do
    let!(:recipe_with_pizza_and_tomato) { create(:recipe, ingredients_list: %w[pizza tomato]) }
    let!(:recipe_with_pizza) { create(:recipe, ingredients_list: ['pizza']) }
    let!(:recipe_tomato_no_pizza) { create(:recipe, ingredients_list: ['tomato']) }

    let!(:recipe_with_pizza_cheese_tomato) { create(:recipe, ingredients_list: %w[pizza cheese tomato]) }
    let!(:recipe_with_pizza_cheese) { create(:recipe, ingredients_list: %w[pizza cheese]) }
    let!(:recipe_with_tomato) { create(:recipe, ingredients_list: ['tomato']) }

    it 'returns matching recipes based on a single ingredient' do
      post '/api/v1/recipes/find', params: { ingredient: 'pizza' }
      response_recipe_data = response.parsed_body['data']

      expect(response).to have_http_status(:success)
      expect(response_recipe_data.count).to eq(4)
    end

    it 'returns matching recipes based on multiple ingredients' do
      post '/api/v1/recipes/find', params: { ingredient: 'pizza, tomato' }
      response_recipe_data = response.parsed_body['data']

      expect(response).to have_http_status(:success)
      expect(response_recipe_data.count).to eq(6)
    end

    it 'returns recipes in descending order based on ingredient count' do
      post '/api/v1/recipes/find', params: { ingredient: 'pizza, tomato, cheese' }
      response_recipe_data = response.parsed_body['data']

      expect(response).to have_http_status(:success)
      expect(response_recipe_data.first['id']).to eq(recipe_with_pizza_cheese_tomato.id)
    end
  end

  # describe 'POST #find' do
  #   let!(:recipe_with_pizza) { create(:recipe, ingredients: ['1 slice of pizza']) }
  #   let!(:recipe_with_pizza_and_tomato) { create(:recipe, ingredients: ['1 slice of pizza', '1 tomato']) }
  #   let!(:recipe_tomato_no_pizza) { create(:recipe, ingredients: ['1 carrot', '1 tomato']) }

  #   it 'returns matching recipes based on a single ingredient' do
  #     post '/api/v1/recipes/find', params: { ingredient: 'pizza' }
  #     response_recipe_data = response.parsed_body['data']
  #     expect(response).to have_http_status(:success)
  #     expect(response_recipe_data.count).to eq(2)
  #   end

  #   it 'returns matching recipes based on multiple ingredients' do
  #     post '/api/v1/recipes/find', params: { ingredient: 'pizza, tomato' }
  #     response_recipe_data = response.parsed_body['data']
  #     expect(response).to have_http_status(:success)
  #     expect(response_recipe_data.count).to eq(1)
  #   end
  # end
end
