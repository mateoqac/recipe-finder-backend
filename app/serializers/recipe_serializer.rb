class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :cook_time, :prep_time, :ingredients, :ratings,
             :cuisine, :category, :author, :image, :created_at, :updated_at

  # def ingredients
  #   object.recipe_ingredients.map do |recipe_ingredient|
  #     "#{recipe_ingredient.quantity} #{recipe_ingredient.unit} #{recipe_ingredient.ingredient.name}"
  #   end
  # end

  def ingredients
    RecipeIngredient.includes(:ingredient)
                    .where(recipe_id: object.id)
                    .map do |recipe_ingredient|
      "#{recipe_ingredient.quantity} #{recipe_ingredient.unit} #{recipe_ingredient.ingredient.name}"
    end
  end
end
