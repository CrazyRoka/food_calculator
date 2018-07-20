require 'rspec_config'

describe Ingredient do
  subject(:tomatoes) { described_class.new('tomatoes', 35) }

  describe '#initialize' do
    it 'should have non negative cost' do
      expect { described_class.new('tomatoes', 0.1) }.not_to raise_error
      expect { described_class.new('tomatoes', 0) }.not_to raise_error
      expect { tomatoes.cost = -0.1 }.to raise_error(ArgumentError)
      expect { tomatoes.cost = -5 }.to raise_error(ArgumentError)
      expect { tomatoes.cost = -5.123 }.to raise_error(ArgumentError)
      expect { tomatoes.cost = 'hello' }.to raise_error(ArgumentError)
      expect { tomatoes.cost = nil }.to raise_error(ArgumentError)
      expect { described_class.new('a', -1) }.to raise_error(ArgumentError)
    end

    it 'should have not empty string name' do
      expect { described_class.new('', 5) }.to raise_error(ArgumentError)
      expect { described_class.new(34, 5) }.to raise_error(ArgumentError)
      expect { described_class.new(/123/, 5) }.to raise_error(ArgumentError)
      expect { described_class.new('t', 0) }.not_to raise_error
      expect { described_class.new('t' * 1024, 0) }.not_to raise_error
      expect { tomatoes.name = '' }.to raise_error(ArgumentError)
      expect { tomatoes.name = 42 }.to raise_error(ArgumentError)
      expect { tomatoes.name = 'LinkUp' }.not_to raise_error
    end

    it 'should allow zero cost' do
      expect { described_class.new('tomatoes', 0) }.not_to raise_error
      expect { tomatoes.cost = 0 }.not_to raise_error
    end
  end

  describe '#==' do
    it 'should be equal' do
      ingredient = described_class.new('tomatoes', 35)
      expect(ingredient).to eq(tomatoes)
    end

    it 'shouldn`t be equal - different names' do
      ingredient = described_class.new('termidor', 35)
      expect(ingredient).not_to eq(tomatoes)
    end

    it 'shouldn`t be equal - different name case' do
      ingredient = described_class.new('Tomatoes', 35)
      expect(ingredient).not_to eq(tomatoes)
    end

    it 'shouldn`t be equal - different costs' do
      ingredient = described_class.new('tomatoes', 20)
      expect(ingredient).not_to eq(tomatoes)
    end

    it 'shouldn`t be equal - different names and costs' do
      ingredient = described_class.new('potatoes', 50)
      expect(ingredient).not_to eq(tomatoes)
    end
  end
end
