require 'rspec_config'

describe MealServing do
  let(:recipe) { soup(servings: 2) }
  subject(:serving) { described_class.new(4, recipe) }

  describe 'writers' do
    it 'should have positive "times"' do
      expect { serving.times = 5 }.not_to raise_error
      expect { serving.times = 0 }.to raise_error(ArgumentError)
      expect { serving.times = -5 }.to raise_error(ArgumentError)
    end
  end

  describe '#total_ingridient_quantities' do
    it 'should return ingredient_quantities' do
      list = serving.total_ingredient_quantities
      expect(list[0].quantity).to eq(500)
      expect(list[1].quantity).to eq(1000)
    end
  end

  describe '#total_cost' do
    it 'should sum up cost' do
      expect(serving.total_cost).to eq(125)

      serving.times = 8
      expect(serving.total_cost).to eq(250)

      serving.times = 16
      expect(serving.total_cost).to eq(500)
    end
  end
end
