require 'rspec_config'

describe MealServing do
  let(:tomatoes_bag) { create_ingredient_quantity('tomatoes', 50, 250) }
  let(:potatoes_bag) { create_ingredient_quantity('potatoes', 37, 343) }
  let(:ingredient_list) { [tomatoes_bag, potatoes_bag] }
  let(:recipe) { Recipe.new('soup', 2, ingredient_list) }
  subject(:serving) { described_class.new(4, recipe) }

  context '#initialize' do
    it 'should have positive "times"' do
      expect { serving.times = 5 }.not_to raise_error
      expect { serving.times = 0.1 }.not_to raise_error
      expect { serving.times = 0 }.to raise_error(ArgumentError)
      expect { serving.times = -5 }.to raise_error(ArgumentError)
    end

    it 'should have valid recipe' do
      expect { serving.recipe = nil }.to raise_error(ArgumentError)
      expect { serving.recipe = 5 }.to raise_error(ArgumentError)
      expect { serving.recipe = recipe }.not_to raise_error
    end
  end

  context '#total_ingridient_quantities' do
    it 'should return ingredient_quantities' do
      list = serving.total_ingredient_quantities
      expect(list[0].quantity).to eq(500)
      expect(list[1].quantity).to eq(686)
    end
  end

  context '#total_cost' do
    it 'should sum up cost' do
      expect(serving.total_cost).to eq(serving.recipe.total_cost * 2)
      serving.times = 10
      expect(serving.total_cost).to eq(serving.recipe.total_cost * 5)
      serving.times = 16
      expect(serving.total_cost).to eq(serving.recipe.total_cost * 8)
    end
  end
end
