FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    cook_time { Faker::Number.within(range: 1..60) }
    prep_time { Faker::Number.within(range: 1..60) }
    ratings { Faker::Number.decimal(l_digits: 2) }
    category { Faker::Food.dish }
    cuisine { Faker::Food.ethnic_category }
    author { Faker::Name.name }
    image { Faker::Avatar.image }

    trait :with_random_ingredients do
      transient do
        ingredients_count { 5 }
      end

      after(:create) do |recipe, evaluator|
        create_list(:recipe_ingredient, evaluator.ingredients_count, recipe:)
      end
    end

    transient do
      ingredients_list { [] }
    end

    after(:create) do |recipe, evaluator|
      evaluator.ingredients_list.each do |ingredient|
        ingredient = Ingredient.find_or_create_by(name: ingredient)
        create(:recipe_ingredient, recipe:, ingredient:)
      end
    end
  end
end
