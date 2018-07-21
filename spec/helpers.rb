require 'meal_plan'

module Helpers
  def tomato(cost:)
    Ingredient.new('tomato', cost)
  end

  def potato(cost:)
    Ingredient.new('potatoe', cost)
  end

  def cucumber(cost:)
    Ingredient.new('cucumber', cost)
  end

  def soup(servings:)
    tomatoes_bag = bag_of(tomato(cost: 50), quantity: 250)
    potatoes_bag = bag_of(potato(cost: 100), quantity: 500)
    Recipe.new('soup', servings, [tomatoes_bag, potatoes_bag])
  end

  def fresh_potato(servings:)
    potatoes_bag = bag_of(potato(cost: 200), quantity: 1500)
    Recipe.new('fresh potatoes', servings, [potatoes_bag])
  end

  def salad(servings:)
    tomatoes_bag = bag_of(tomato(cost: 50), quantity: 250)
    potatoes_bag = bag_of(potato(cost: 100), quantity: 500)
    cucumber_bag = bag_of(cucumber(cost: 25), quantity: 1000)
    Recipe.new('salad', servings, [potatoes_bag, tomatoes_bag, cucumber_bag])
  end

  def bag_of(ingredient, quantity:)
    IngredientQuantity.new(ingredient, quantity)
  end
end
