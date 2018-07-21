require 'rspec_config'

describe MealPlan do
  let(:big_mak) { MealServing.new(8, fresh_potato(servings: 4)) }
  let(:salad_mak) { MealServing.new(6, salad(servings: 1)) }
  let(:soup_mak) { MealServing.new(2, soup(servings: 2)) }

  subject(:festival) { described_class.new('Festival plan', 200, [big_mak, salad_mak]) }
  subject(:course) { described_class.new('course', 10, [soup_mak]) }

  context 'writers' do
    it 'should have positive integer number of individuals' do
      expect { course.individuals_count = 1 }.not_to raise_error
      expect { course.individuals_count = 1.1 }.to raise_error(ArgumentError)
      expect { course.individuals_count = -5 }.to raise_error(ArgumentError)
    end

    it 'should have not empty string name' do
      expect { course.name = 'Test' }.not_to raise_error
      expect { course.name = '' }.to raise_error(ArgumentError)
    end

    it 'should have non empty array of meal servings' do
      expect { course.meal_servings = [salad_mak] }.not_to raise_error
      expect { course.meal_servings = [] }.to raise_error(ArgumentError)
    end
  end

  describe '#grouped_ingridient_quantities' do
    let(:potatoes_bag) { bag_of(potato(cost: 100), quantity: 5000) }
    let(:tomatoes_bag) { bag_of(tomato(cost: 50), quantity: 2500) }
    let(:cucumber_bag) { bag_of(cucumber(cost: 25), quantity: 6000 * 200) }
    let(:fresh_potatoes_bag) { bag_of(potato(cost: 200), quantity: 3000 * 200) }
    it 'should group quantities by ingredients' do
      groups = course.grouped_ingredient_quantities
      expect(groups.size).to eq(2)
      expect(groups.include?(tomatoes_bag)).to be_truthy
      expect(groups.include?(potatoes_bag)).to be_truthy

      potatoes_bag.quantity = 3000 * 200
      tomatoes_bag.quantity = 1500 * 200

      groups = festival.grouped_ingredient_quantities
      expect(groups.size).to eq(4)
      expect(groups.include?(cucumber_bag)).to be_truthy
      expect(groups.include?(fresh_potatoes_bag)).to be_truthy
      expect(groups.include?(tomatoes_bag)).to be_truthy
      expect(groups.include?(potatoes_bag)).to be_truthy
    end
  end

  describe '#total_cost' do
    it 'should sum up total cost' do
      expect(course.total_cost).to be_within(0.001).of(625)
      expect(festival.total_cost).to be_within(0.001).of(225000)
    end
  end
end
