require 'meal_serving'

module Helpers
  def create_ingredient_quantity(name, cost, quantity)
    ingredient = Ingredient.new(name, cost)
    IngredientQuantity.new(ingredient, quantity)
  end
end
