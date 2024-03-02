FactoryBot.define do
  factory :recipe_ingredient do
    recipe
    ingredient
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit { Faker::Food.metric_measurement }
  end
end
