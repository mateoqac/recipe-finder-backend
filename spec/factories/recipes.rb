# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { 'Sample Recipe' }
    cook_time { 30 }
    prep_time { 15 }
    ingredients { ['1 cup milk', '1 cup flour', '1 egg'] }
    ratings { 4.5 }
    cuisine { 'Italian' }
    category { 'Main Dish' }
    author { 'John Doe' }
    image { 'https://fastly.picsum.photos/id/488/200/300.jpg?hmac=0juhK9GVPUpSjHaRjdjZO5Fw2bcfSYHNjXLYTg3ZsQU' }
  end
end
