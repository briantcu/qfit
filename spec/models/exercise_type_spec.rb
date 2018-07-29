# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  type_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe ExerciseType, type: :model do

  before(:each) do
    Exercise.destroy_all
    ExerciseType.destroy_all
    @t1 = FactoryGirl.create(:exercise_type)
    FactoryGirl.create(:exercise, exercise_type: @t1, difficulty: 1, paid_tier: 1, name: "alpha")
    FactoryGirl.create(:exercise, exercise_type: @t1, difficulty: 2, paid_tier: 2, name: "beta")
    FactoryGirl.create(:exercise, exercise_type: @t1, difficulty: 3, paid_tier: 1, name: "charlie")

    @t14 = FactoryGirl.create(:exercise_type, id: 14)
    FactoryGirl.create(:exercise, exercise_type: @t14)
    FactoryGirl.create(:exercise, exercise_type: @t14)
    FactoryGirl.create(:exercise, exercise_type: @t14)
    t15 = FactoryGirl.create(:exercise_type, id: 15)
    FactoryGirl.create(:exercise, exercise_type: t15)
    FactoryGirl.create(:exercise, exercise_type: t15)
    FactoryGirl.create(:exercise, exercise_type: t15)
    t16 = FactoryGirl.create(:exercise_type, id: 16)
    FactoryGirl.create(:exercise, exercise_type: t16)
    FactoryGirl.create(:exercise, exercise_type: t16)
    FactoryGirl.create(:exercise, exercise_type: t16)
  end

  it 'returns the right exercises based on type, experience level, and paid tier' do
    exercises = @t1.get_exercises(2, 1)
    expect(exercises.map(&:name).include?("alpha")).to be(true)
    expect(exercises.count).to eq(1)

    exercises = @t1.get_exercises(3, 2)
    expect(exercises.count).to eq(3)
  end

  it 'returns all ab exercises' do
    exercises = @t14.get_exercises(nil, nil)
    expect(exercises.count).to eq(9)
  end

end
