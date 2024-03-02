require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:ingredient) }
  end

  it 'is valid with valid attributes' do
    recipe_ingredient = build(:recipe_ingredient)
    expect(recipe_ingredient).to be_valid
  end
end
