require 'rspec_config'

describe Recipe do
  subject(:recipe) { soup(servings: 2) }

  context 'writers' do
    it 'should have not empty string name' do
      expect { recipe.name = '' }.to raise_error(ArgumentError)
      expect { recipe.name = 'LinkUp' }.not_to raise_error
    end

    it 'should have positive servings' do
      expect { recipe.servings_count = 1.5 }.not_to raise_error
      expect { recipe.servings_count = 0 }.to raise_error(ArgumentError)
      expect { recipe.servings_count = -1 }.to raise_error(ArgumentError)
    end

    it 'should have non empty list of ingredient_quantities' do
      expect { recipe.ingredient_quantities = [] }.to raise_error(ArgumentError)
    end
  end

  describe '#total_cost' do
    it 'should calculate total cost' do
      expect(recipe.total_cost).to be_within(0.001).of(62.5)

      recipe.servings_count = 1
      expect(recipe.total_cost).to be_within(0.001).of(62.5)

      recipe.ingredient_quantities.pop
      expect(recipe.total_cost).to be_within(0.001).of(12.5)
    end
  end

  describe '#ingredient_quantities_per_servings' do
    it 'should take positive arguments' do
      expect { recipe.ingredient_quantities_per_servings(0) }.to raise_error(ArgumentError)
      expect { recipe.ingredient_quantities_per_servings(-1) }.to raise_error(ArgumentError)
    end

    it 'should calculate ingredient quantities per "n" servings' do
      ingredient_list = recipe.ingredient_quantities_per_servings(2)
      expect(ingredient_list[0].quantity).to be_within(0.001).of(250)
      expect(ingredient_list[1].quantity).to be_within(0.001).of(500)

      ingredient_list = recipe.ingredient_quantities_per_servings(12)
      expect(ingredient_list[0].quantity).to be_within(0.001).of(1500)
      expect(ingredient_list[1].quantity).to be_within(0.001).of(3000)
    end
  end

  describe '#ingredient_quantities_per_one_serving' do
    it 'should calculate ingredient quantities per one servings' do
      ingredient_list = recipe.ingredient_quantities_per_one_serving
      expect(ingredient_list[0].quantity).to be_within(0.001).of(125)
      expect(ingredient_list[1].quantity).to be_within(0.001).of(250)

      recipe.servings_count = 5
      ingredient_list = recipe.ingredient_quantities_per_one_serving
      expect(ingredient_list[0].quantity).to be_within(0.001).of(50)
      expect(ingredient_list[1].quantity).to be_within(0.001).of(100)
    end
  end

  describe '#cost_of_one_serving' do
    it 'should calculate cost of one serving' do
      expect(recipe.cost_of_one_serving).to be_within(0.001).of(31.25)

      recipe.servings_count = 1
      expect(recipe.cost_of_one_serving).to be_within(0.001).of(62.5)
    end
  end
end
