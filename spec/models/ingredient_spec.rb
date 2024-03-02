require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end

  it 'is valid with valid attributes' do
    ingredient = build(:ingredient)
    expect(ingredient).to be_valid
  end

  it 'is not valid without a name' do
    ingredient = build(:ingredient, name: nil)
    expect(ingredient).not_to be_valid
  end
end
