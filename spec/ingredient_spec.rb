require 'rspec_config'

describe Ingredient do
  subject(:pomidor) { tomato(cost: 35) }

  describe '#initialize' do
    it 'should have non negative cost' do
      expect { tomato(cost: 5) }.not_to raise_error
      expect { tomato(cost: 0) }.not_to raise_error
      expect { tomato(cost: -0.1) }.to raise_error(ArgumentError)
      expect { tomato(cost: -5) }.to raise_error(ArgumentError)
    end

    it 'should have not empty string name' do
      expect { described_class.new('tomatoe', 0) }.not_to raise_error
      expect { described_class.new('', 0) }.to raise_error(ArgumentError)
    end
  end

  describe '#==' do
    it 'should be equal' do
      ingredient = described_class.new('tomato', 35)
      expect(ingredient).to eq(pomidor)
    end

    it 'shouldn`t be equal - different names' do
      ingredient = described_class.new('termidor', 35)
      expect(ingredient).not_to eq(pomidor)
    end

    it 'shouldn`t be equal - different name case' do
      ingredient = described_class.new('Tomato', 35)
      expect(ingredient).not_to eq(pomidor)
    end

    it 'shouldn`t be equal - different costs' do
      ingredient = described_class.new('tomato', 20)
      expect(ingredient).not_to eq(pomidor)
    end

    it 'shouldn`t be equal - different names and costs' do
      ingredient = described_class.new('potatoes', 50)
      expect(ingredient).not_to eq(pomidor)
    end
  end
end
