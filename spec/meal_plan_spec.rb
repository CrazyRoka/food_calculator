require 'rspec_config'

describe MealPlan do
  let(:tomatoes_bag) { create_ingredient_quantity('tomatoes', 50, 250) }
  let(:potatoes_bag) { create_ingredient_quantity('potatoes', 37, 343) }
  let(:cucumber_bag) { create_ingredient_quantity('cucumber', 70, 1250) }
  let(:meat_bag) { create_ingredient_quantity('meat', 150, 500) }

  let(:soup_recipe) { Recipe.new('soup', 3, [potatoes_bag, tomatoes_bag]) }
  let(:potatoes_recipe) { Recipe.new('fresh potatoes', 4, [potatoes_bag]) }
  let(:salat_recipe) { Recipe.new('salat', 1, [potatoes_bag, tomatoes_bag, cucumber_bag]) }

  let(:big_mak) { MealServing.new(8, potatoes_recipe) }
  let(:salat_mak) { MealServing.new(6, salat_recipe) }
  let(:soup_mak) { MealServing.new(2, soup_recipe) }

  subject(:festival) { described_class.new('Festival plan', 200, [big_mak, salat_mak]) }
  subject(:course) { described_class.new('course', 10, [soup_mak]) }

  context 'writers' do
    it 'should have positive integer number of individuals' do
      expect { course.individuals_count = 5 }.not_to raise_error
      expect { course.individuals_count = 1 }.not_to raise_error
      expect { course.individuals_count = 1.1 }.to raise_error(ArgumentError)
      expect { course.individuals_count = -5 }.to raise_error(ArgumentError)
    end

    it 'should have not empty string name' do
      expect { course.name = 'Roka' }.not_to raise_error
      expect { course.name = 'Test' }.not_to raise_error
      expect { course.name = '' }.to raise_error(ArgumentError)
      expect { course.name = 5 }.to raise_error(ArgumentError)
    end

    it 'should have non empty array of meal servings' do
      expect { course.meal_servings = [big_mak] }.not_to raise_error
      expect { course.meal_servings = [salat_mak, big_mak, soup_mak, big_mak] }.not_to raise_error
      expect { course.meal_servings = [salat_mak] }.not_to raise_error
      expect { course.meal_servings = [1, 2, 3] }.to raise_error(ArgumentError)
      expect { course.meal_servings = [nil, 't'] }.to raise_error(ArgumentError)
    end
  end

  context '#grouped_ingridient_quantities' do
    it 'should group quantities by ingridients' do
      groups = course.grouped_ingridient_quantities
      expect(groups[Ingredient.new('tomatoes', 50)]).to be_within(1e-6).of(1666.66666667)
      expect(groups[Ingredient.new('potatoes', 37)]).to be_within(1e-6).of(2286.66666667)
    end
  end

  context '#total_cost' do
    it 'should sum up total cost' do
      expect(course.total_cost).to be_within(1e-6).of(167.94)
    end
  end
end
