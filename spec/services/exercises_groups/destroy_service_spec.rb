# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesGroups::DestroyService do
  describe '#call' do
    it 'destroys received exercises_group with its exercise_schedules' do
      workout_plan = create(:workout_plan)
      create(:exercises_group, workout_plan:, execution_sequence: 1)
      second_exercises_group = create(:exercises_group, workout_plan:, execution_sequence: 2)
      create(:exercises_group, workout_plan:, execution_sequence: 3)

      described_class.call(id: second_exercises_group.id)

      expect(ExercisesGroup.count).to be(2)
    end

    it 'fix execution sequence' do
      workout_plan = create(:workout_plan)
      first_exercises_group = create(:exercises_group, workout_plan:, execution_sequence: 1)
      second_exercises_group = create(:exercises_group, workout_plan:, execution_sequence: 2)
      third_exercises_group = create(:exercises_group, workout_plan:, execution_sequence: 3)

      described_class.call(id: second_exercises_group.id)

      exercises_groups = workout_plan.exercises_groups.order(execution_sequence: :asc)
      expect(exercises_groups).to match([first_exercises_group, third_exercises_group])
      expect(exercises_groups.last.execution_sequence).to be(2)
    end
  end
end
