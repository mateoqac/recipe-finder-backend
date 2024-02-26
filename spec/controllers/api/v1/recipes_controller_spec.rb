# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :request do
  before do
    create_list(:recipe, 5)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].count).to eq(5)
    end
  end

  describe 'POST #find' do
    let!(:recipe_with_pizza) { create(:recipe, ingredients: ['1 slice of pizza']) }
    it 'returns matching recipes based on the ingredient' do
      post '/api/v1/recipes/find', params: { ingredient: 'pizza' }
      response_recipe_data = JSON.parse(response.body)['data']
      expect(response).to have_http_status(:success)
      expect(response_recipe_data.count).to eq(1)
      expect(response_recipe_data.first['id']).to eq(recipe_with_pizza.id)
    end
  end
end
