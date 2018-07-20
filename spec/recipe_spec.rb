require 'rspec_config'

describe Recipe do
  let(:tomatoes_bag) { create_ingredient_quantity('tomatoes', 50, 250) }
  let(:potatoes_bag) { create_ingredient_quantity('potatoes', 37, 343) }
  let(:ingredient_list) { [tomatoes_bag, potatoes_bag] }
  subject(:recipe) { described_class.new('soup', 2, ingredient_list) }

  context '#initialize' do
    it 'should have not empty string name' do
      expect { recipe.name = '' }.to raise_error(ArgumentError)
      expect { recipe.name = 123 }.to raise_error(ArgumentError)
      expect { recipe.name = 'LinkUp' }.not_to raise_error
      expect { recipe.name = 'soup' }.not_to raise_error
    end

    it 'should have positive servings' do
      expect { recipe.servings_count = 3 }.not_to raise_error
      expect { recipe.servings_count = 1.5 }.not_to raise_error
      expect { recipe.servings_count = 0 }.to raise_error(ArgumentError)
      expect { recipe.servings_count = -0.1 }.to raise_error(ArgumentError)
      expect { recipe.servings_count = -1 }.to raise_error(ArgumentError)
      expect { recipe.servings_count = nil }.to raise_error(ArgumentError)
      expect { recipe.servings_count = 'error' }.to raise_error(ArgumentError)
    end

    it 'should have non empty list of ingredient_quantities' do
      expect { recipe.ingredient_quantities = [] }.to raise_error(ArgumentError)
      expect { recipe.ingredient_quantities = [1] }.to raise_error(ArgumentError)
      expect { recipe.ingredient_quantities = nil }.to raise_error(ArgumentError)
      expect { recipe.ingredient_quantities = [tomatoes_bag] }.not_to raise_error
      expect { recipe.ingredient_quantities = [potatoes_bag] }.not_to raise_error
    end
  end

  context '#total_cost' do
    it 'should calculate total cost' do
      expect(recipe.total_cost).to be_within(1e-6).of(25.191)
      recipe.servings_count = 1
      expect(recipe.total_cost).to be_within(1e-6).of(25.191)
      recipe.ingredient_quantities.pop
      expect(recipe.total_cost).to be_within(1e-6).of(12.5)
    end
  end

  context '#ingredient_quantities_per_servings' do
    it 'should raise error' do
      expect { recipe.ingredient_quantities_per_servings(0) }.to raise_error(ArgumentError)
      expect { recipe.ingredient_quantities_per_servings(-1) }.to raise_error(ArgumentError)
    end

    it 'should calculate ingredient quantities per "n" servings' do
      recipe.servings_count = 1
      ingredient_list = recipe.ingredient_quantities_per_servings(2)
      expect(ingredient_list[0].quantity).to be_within(1e-6).of(500)
      expect(ingredient_list[1].quantity).to be_within(1e-6).of(686)
      ingredient_list = recipe.ingredient_quantities_per_servings(12)
      expect(ingredient_list[0].quantity).to be_within(1e-6).of(3000)
      expect(ingredient_list[1].quantity).to be_within(1e-6).of(4116)
    end
  end

  context '#ingredient_quantities_per_one_serving' do
    it 'should calculate ingredient quantities per one servings' do
      recipe.servings_count = 1
      ingredient_list = recipe.ingredient_quantities_per_one_serving
      expect(ingredient_list[0].quantity).to be_within(1e-6).of(250)
      expect(ingredient_list[1].quantity).to be_within(1e-6).of(343)
      recipe.servings_count = 5
      ingredient_list = recipe.ingredient_quantities_per_one_serving
      expect(ingredient_list[0].quantity).to be_within(1e-6).of(50)
      expect(ingredient_list[1].quantity).to be_within(1e-6).of(68.6)
    end
  end

  context '#cost_of_one_serving' do
    it 'should calculate cost of one serving' do
      expect(recipe.cost_of_one_serving).to be_within(1e-6).of(12.5955)
      recipe.servings_count = 1
      expect(recipe.cost_of_one_serving).to be_within(1e-6).of(25.191)
    end
  end
end
