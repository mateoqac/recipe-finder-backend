# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end

  it 'is valid with valid attributes' do
    recipe = build(:recipe)
    expect(recipe).to be_valid
  end

  it 'is not valid without a title' do
    recipe = build(:recipe, title: nil)
    expect(recipe).not_to be_valid
  end
end
