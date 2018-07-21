require 'ingredient'

class IngredientQuantity
  attr_reader :ingredient, :quantity

  COST_PER_GRAM = 1e-3

  def initialize(ingredient, quantity)
    self.ingredient, self.quantity = ingredient, quantity
  end

  def +(other)
    if other.ingredient != ingredient
      raise ArgumentError, 'ingredients are not equal'
    end
    IngredientQuantity.new(ingredient, other.quantity + quantity)
  end

  def *(multiplier)
    ArgumentChecker.check(multiplier, 'multiplier', type: Numeric, positive: true)
    IngredientQuantity.new(ingredient, quantity * multiplier)
  end

  alias eql? ==

  def ==(other)
    other.is_a?(IngredientQuantity) && other.ingredient == ingredient && other.quantity == quantity
  end

  def total_cost
    quantity * ingredient.cost * COST_PER_GRAM
  end

  def ingredient=(ingredient)
    ArgumentChecker.check(ingredient, 'ingredient', type: Ingredient)
    @ingredient = ingredient
  end

  def quantity=(quantity)
    ArgumentChecker.check(quantity, 'quantity', type: Numeric, positive: true)
    @quantity = quantity
  end
end
