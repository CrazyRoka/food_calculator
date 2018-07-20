require 'rspec_config'

describe IngredientQuantity do
  let(:tomatoe) { Ingredient.new('tomatoe', 35) }
  let(:potatoe) { Ingredient.new('potatoe', 50) }
  subject(:tomatoe_bag) { described_class.new(tomatoe, 250) }
  subject(:potatoe_bag) { described_class.new(potatoe, 473) }

  context '#initialize' do
    it 'should work with positive quantity' do
      expect { described_class.new(tomatoe, 123) }.not_to raise_error
      expect { tomatoe_bag.quantity = 60 }.not_to raise_error
      expect { described_class.new(tomatoe, 1) }.not_to raise_error
      expect { described_class.new(tomatoe, 0) }.to raise_error(ArgumentError)
      expect { tomatoe_bag.quantity = -0.1 }.to raise_error(ArgumentError)
      expect { described_class.new(tomatoe, -5) }.to raise_error(ArgumentError)
      expect { described_class.new(tomatoe, nil) }.to raise_error(ArgumentError)
      expect { tomatoe_bag.quantity = nil }.to raise_error(ArgumentError)
    end

    it 'should have valid ingredient' do
      expect { described_class.new(tomatoe, 500) }.not_to raise_error
      expect { described_class.new('hello', 5000) }.to raise_error(ArgumentError)
      expect { described_class.new(nil, 5000) }.to raise_error(ArgumentError)
      expect { tomatoe_bag.ingredient = 'bye' }.to raise_error(ArgumentError)
      expect { tomatoe_bag.ingredient = nil }.to raise_error(ArgumentError)
    end
  end

  context '#+' do
    it 'should add quantities' do
      other_tomatoe_bag = described_class.new(tomatoe, 350)
      summary_bag = tomatoe_bag + other_tomatoe_bag
      summary_quantity = 600
      expect(summary_bag.quantity).to eq(summary_quantity)
    end

    it 'shouldn`t add different ingredients' do
      expect { potatoe_bag + tomatoe_bag }.to raise_error(ArgumentError)
    end
  end

  context '#*' do
    it 'should multiply quantity' do
      summary_bag = tomatoe_bag * 5
      summary_quantity = 1250
      expect(summary_bag.quantity).to eq(summary_quantity)
    end

    it 'shouldn`t multiply by non positive number' do
      expect { tomatoe_bag * 123 }.not_to raise_error
      expect { tomatoe_bag * 0.1 }.not_to raise_error
      expect { tomatoe_bag * 0 }.to raise_error(ArgumentError)
      expect { tomatoe_bag * -0.1 }.to raise_error(ArgumentError)
      expect { tomatoe_bag * -123 }.to raise_error(ArgumentError)
    end
  end

  context '#total_cost' do
    it 'should calculate cost' do
      expect(tomatoe_bag.total_cost).to be_within(1e-6).of(8.75)
      expect(potatoe_bag.total_cost).to be_within(1e-6).of(23.65)
    end
  end
end
