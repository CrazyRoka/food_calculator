require 'argument_checker'

class Ingredient
  attr_reader :name, :cost

  # cost of 1 kg
  def initialize(name, cost)
    self.name, self.cost = name, cost
  end

  def ==(other)
    other.is_a?(Ingredient) && other.name == name && other.cost == cost
  end

  alias eql? ==

  def hash
    name.hash ^ cost.hash
  end

  def name=(name)
    ArgumentChecker.check(name, 'name', type: String, not_empty: true)
    @name = name
  end

  def cost=(cost)
    ArgumentChecker.check(cost, 'cost', type: Numeric, non_negative: true)
    @cost = cost
  end
end
