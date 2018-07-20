require 'rspec_config'

describe IngredientQuantity do
  let(:tomatoes) { Ingredient.new('tomatoes', 35) }
  let(:potatoes) { Ingredient.new('potatoes', 50) }
  subject(:tomatoes_bag) { described_class.new(tomatoes, 250) }
  subject(:potatoes_bag) { described_class.new(potatoes, 473) }

  context 'initializer and writers' do
    it 'should work with positive quantity' do
      expect { described_class.new(tomatoes, 123) }.not_to raise_error
      expect { tomatoes_bag.quantity = 60 }.not_to raise_error
      expect { described_class.new(tomatoes, 1) }.not_to raise_error
      expect { described_class.new(tomatoes, 0) }.to raise_error(ArgumentError)
      expect { tomatoes_bag.quantity = -0.1 }.to raise_error(ArgumentError)
      expect { described_class.new(tomatoes, -5) }.to raise_error(ArgumentError)
      expect { described_class.new(tomatoes, nil) }.to raise_error(ArgumentError)
      expect { tomatoes_bag.quantity = nil }.to raise_error(ArgumentError)
    end

    it 'should have valid ingredient' do
      expect { described_class.new(tomatoes, 500) }.not_to raise_error
      expect { described_class.new('hello', 5000) }.to raise_error(ArgumentError)
      expect { described_class.new(nil, 5000) }.to raise_error(ArgumentError)
      expect { tomatoes_bag.ingredient = 'bye' }.to raise_error(ArgumentError)
      expect { tomatoes_bag.ingredient = nil }.to raise_error(ArgumentError)
    end
  end

  context '#+' do
    it 'should add quantities' do
      other_tomatoes_bag = described_class.new(tomatoes, 350)
      summary_bag = tomatoes_bag + other_tomatoes_bag
      summary_quantity = 600
      expect(summary_bag.quantity).to eq(summary_quantity)
    end

    it 'shouldn`t add different ingredients' do
      expect { potatoes_bag + tomatoes_bag }.to raise_error(ArgumentError)
    end
  end

  context '#*' do
    it 'should multiply quantity' do
      summary_bag = tomatoes_bag * 5
      summary_quantity = 1250
      expect(summary_bag.quantity).to eq(summary_quantity)
    end

    it 'shouldn`t multiply by non positive number' do
      expect { tomatoes_bag * 123 }.not_to raise_error
      expect { tomatoes_bag * 0.1 }.not_to raise_error
      expect { tomatoes_bag * 0 }.to raise_error(ArgumentError)
      expect { tomatoes_bag * -0.1 }.to raise_error(ArgumentError)
      expect { tomatoes_bag * -123 }.to raise_error(ArgumentError)
    end
  end

  context '#total_cost' do
    it 'should calculate cost' do
      expect(tomatoes_bag.total_cost).to be_within(1e-6).of(8.75)
      expect(potatoes_bag.total_cost).to be_within(1e-6).of(23.65)
    end
  end
end
