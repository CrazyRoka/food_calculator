require 'rspec_config'

describe IngredientQuantity do
  describe '#initialize' do
    it 'should work with positive quantity' do
      expect { bag_of(tomato(cost: 10), quantity: 5) }.not_to raise_error
      expect { bag_of(tomato(cost: 10), quantity: 1) }.not_to raise_error
      expect { bag_of(tomato(cost: 10), quantity: 0) }.to raise_error(ArgumentError)
      expect { bag_of(tomato(cost: 10), quantity: -5) }.to raise_error(ArgumentError)
    end
  end

  subject(:tomatoes_bag) { bag_of(tomato(cost: 10), quantity: 250) }
  subject(:potatoes_bag) { bag_of(potato(cost: 5), quantity: 1500) }

  describe '#+' do
    it 'should add quantities' do
      other_tomatoes_bag = bag_of(tomato(cost: 10), quantity: 350)
      summary_bag = tomatoes_bag + other_tomatoes_bag
      expect(summary_bag.quantity).to eq(600)
    end

    it 'shouldn`t add different ingredients' do
      expect { potatoes_bag + tomatoes_bag }.to raise_error(ArgumentError)
    end
  end

  describe '#*' do
    it 'should multiply quantity' do
      summary_bag = tomatoes_bag * 5
      expect(summary_bag.quantity).to eq(1250)
    end

    it 'shouldn`t multiply by non positive number' do
      expect { tomatoes_bag * 5 }.not_to raise_error
      expect { tomatoes_bag * 0.1 }.not_to raise_error
      expect { tomatoes_bag * 0 }.to raise_error(ArgumentError)
      expect { tomatoes_bag * -5 }.to raise_error(ArgumentError)
    end
  end

  describe '#total_cost' do
    it 'should calculate cost' do
      expect(tomatoes_bag.total_cost).to be_within(0.001).of(2.5)
      expect(potatoes_bag.total_cost).to be_within(0.001).of(7.5)
    end
  end
end
