# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesGroups::CreateService do
  describe '#call' do
    context 'when received params is invalid' do
      it 'returns an exercises_group object with error messages' do
        params = { workout_plan_id: nil }
        result = described_class.call(params)
        expect(result.errors.full_messages).not_to(be_empty)
        expect(result).to be_a(ExercisesGroup)
      end
    end

    context 'when receive valid params' do
      let(:workout_plan) { create(:workout_plan) }
      let(:exercise) { create(:exercise) }
      let(:params) do
        {
          workout_plan_id: workout_plan.id,
          exercise_schedules: [
            {
              exercise_id: exercise.id,
              repetitions: 'SIX',
              rest: 'FREE',
              exercise_sequence: 1
            }
          ]
        }
      end

      it 'creates an exercises_group' do
        expect do
          described_class.call(params)
        end.to change(ExercisesGroup, :count).by(1)
      end

      it 'returns an valid exercises_group object' do
        expect(described_class.call(params)).to be_a(ExercisesGroup)
      end

      it 'creates execrise_schedules' do
        expect do
          described_class.call(params)
        end.to change(ExerciseSchedule, :count).by(1)
      end
    end
  end
end
