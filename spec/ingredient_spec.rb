require 'rspec_config'

describe Ingredient do
  subject(:tomatoe) { described_class.new('tomatoe', 35) }

  describe '#initialize' do
    it 'should have non negative cost' do
      expect { described_class.new('tomatoe', 0.1) }.not_to raise_error
      expect { described_class.new('tomatoe', 0) }.not_to raise_error
      expect { tomatoe.cost = -0.1 }.to raise_error(ArgumentError)
      expect { tomatoe.cost = -5 }.to raise_error(ArgumentError)
      expect { tomatoe.cost = -5.123 }.to raise_error(ArgumentError)
      expect { tomatoe.cost = 'hello' }.to raise_error(ArgumentError)
      expect { tomatoe.cost = nil }.to raise_error(ArgumentError)
      expect { described_class.new('a', -1) }.to raise_error(ArgumentError)
    end

    it 'should have not empty string name' do
      expect { described_class.new('', 5) }.to raise_error(ArgumentError)
      expect { described_class.new(34, 5) }.to raise_error(ArgumentError)
      expect { described_class.new(/123/, 5) }.to raise_error(ArgumentError)
      expect { described_class.new('t', 0) }.not_to raise_error
      expect { described_class.new('t' * 1024, 0) }.not_to raise_error
      expect { tomatoe.name = '' }.to raise_error(ArgumentError)
      expect { tomatoe.name = 42 }.to raise_error(ArgumentError)
      expect { tomatoe.name = 'LinkUp' }.not_to raise_error
    end

    it 'should allow zero cost' do
      expect { described_class.new('tomatoe', 0) }.not_to raise_error
      expect { tomatoe.cost = 0 }.not_to raise_error
    end
  end

  describe '#==' do
    it 'should be equal' do
      ingredient = described_class.new('tomatoe', 35)
      expect(ingredient).to eq(tomatoe)
    end

    it 'shouldn`t be equal - different names' do
      ingredient = described_class.new('termidor', 35)
      expect(ingredient).not_to eq(tomatoe)
    end

    it 'shouldn`t be equal - different name case' do
      ingredient = described_class.new('Tomatoe', 35)
      expect(ingredient).not_to eq(tomatoe)
    end

    it 'shouldn`t be equal - different costs' do
      ingredient = described_class.new('tomatoe', 20)
      expect(ingredient).not_to eq(tomatoe)
    end

    it 'shouldn`t be equal - different names and costs' do
      ingredient = described_class.new('potatoe', 50)
      expect(ingredient).not_to eq(tomatoe)
    end
  end
end
