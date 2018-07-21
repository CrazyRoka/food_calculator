require 'meal_serving'

class MealPlan
  attr_reader :name, :individuals_count, :meal_servings

  def initialize(name, individuals_count, meal_servings)
    self.name = name
    self.individuals_count = individuals_count
    self.meal_servings = meal_servings
  end

  def grouped_ingredient_quantities
    group = Hash.new(0)
    meal_servings.each do |meal_serving|
      meal_serving.total_ingredient_quantities.each do |ingredient_quantity|
        ingredient = ingredient_quantity.ingredient
        group[ingredient] += ingredient_quantity.quantity * individuals_count
      end
    end
    group.map { |key, value| IngredientQuantity.new(key, value) }
  end

  def total_cost
    meal_servings.reduce(0) { |sum, serving| sum + serving.total_cost } * individuals_count
  end

  def name=(name)
    ArgumentChecker.check(name, 'name', type: String, not_empty: true)
    @name = name
  end

  def individuals_count=(individuals_count)
    ArgumentChecker.check(individuals_count, 'individuals_count', type: Integer,
                                                                positive: true)
    @individuals_count = individuals_count
  end

  def meal_servings=(meal_servings)
    ArgumentChecker.check(meal_servings, 'meal_servings', type: Array,
                                                          not_empty: true)
    meal_servings.each.with_index do |meal_serving, index|
      ArgumentChecker.check(meal_serving, "Array[#{index}]", type: MealServing)
    end
    @meal_servings = meal_servings
  end
end
