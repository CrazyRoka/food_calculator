require 'recipe'

class MealServing
  attr_reader :times, :recipe

  def initialize(times, recipe)
    self.times, self.recipe = times, recipe
  end

  def total_ingridient_quantities
    recipe.ingredient_quantities_per_servings(times)
  end

  def total_cost
    recipe.cost_of_one_serving * times
  end

  def times=(times)
    ArgumentChecker.check(times, 'times', type: Numeric, positive: true)
    @times = times
  end

  def recipe=(recipe)
    ArgumentChecker.check(recipe, 'recipe', type: Recipe)
    @recipe = recipe
  end
end
