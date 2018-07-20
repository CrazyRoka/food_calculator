require 'ingredient_quantity'

class Recipe
  attr_reader :name, :servings_count, :ingredient_quantities

  def initialize(name, servings_count, ingredient_quantities)
    self.name = name
    self.servings_count = servings_count
    self.ingredient_quantities = ingredient_quantities
  end

  def total_cost
    ingredient_quantities.reduce(0) { |sum, elem| sum + elem.total_cost }
  end

  def ingredient_quantities_per_servings(number_of_servings)
    ArgumentChecker.check(number_of_servings, 'number_of_servings',
                          type: Numeric,
                          positive: true)

    coeficient = number_of_servings / servings_count.to_f
    ingredient_quantities.map do |ingredient_quantity|
      ingredient_quantity = ingredient_quantity.clone
      ingredient_quantity.quantity *= coeficient
      ingredient_quantity
    end
  end

  def ingredient_quantities_per_one_serving
    ingredient_quantities_per_servings(1)
  end

  def cost_of_one_serving
    total_cost / servings_count.to_f
  end

  def name=(name)
    ArgumentChecker.check(name, 'name', type: String, not_empty: true)
    @name = name
  end

  def servings_count=(servings_count)
    ArgumentChecker.check(servings_count, 'servings_count',
                          type: Numeric,
                          positive: true)
    @servings_count = servings_count
  end

  def ingredient_quantities=(ingredient_quantities)
    ArgumentChecker.check(ingredient_quantities, 'ingredient_quantities',
                          type: Array,
                          not_empty: true)

    ingredient_quantities.each.with_index do |ingredient_quantity, index|
      ArgumentChecker.check(ingredient_quantity,
                            "ingredient_quantities[#{index}]",
                            type: IngredientQuantity)
    end

    @ingredient_quantities = ingredient_quantities
  end
end
