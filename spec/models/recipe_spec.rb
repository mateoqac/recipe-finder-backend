# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:cook_time).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:prep_time).is_greater_than_or_equal_to(0) }
  end
end
