# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExercisesGroups', type: :request do
  let(:personal) { create(:personal) }

  describe 'POST /exercises_groups' do
    context 'when receive correct params' do
      let!(:exercise) { create(:exercise) }
      let!(:workout_plan) { create(:workout_plan, personal:) }

      let(:params) do
        {
          workout_plan_id: workout_plan.id,
          exercise_schedules: [
            { exercise_id: exercise.id, rest: 'FREE', exercise_sequence: '1',
              repetitions: 'PYRAMID' }
          ]
        }
      end

      let(:exercise_schedule) { ExerciseSchedule.last }

      it 'creates a new exercises_group with its schedule_exercises' do
        post('/api/exercises_groups', params:, headers: headers(user: personal.user))
        expect(response).to have_http_status(:created)
        expect(ExercisesGroup.count).to match(1)
        expect(ExerciseSchedule.count).to match(1)
        expect(response.parsed_body).to match(
          {
            'exercises_group' => {
              'id' => ExercisesGroup.last.id,
              'execution_sequence' => 1,
              'exercise_schedules' => [
                {
                  'exercise_schedule' => {
                    'id' => exercise_schedule.id,
                    'exercises_group_id' => exercise_schedule.exercises_group_id,
                    'rest' => exercise_schedule.rest,
                    'repetitions' => exercise_schedule.repetitions,
                    'exercise_sequence' => 1
                  }
                }
              ]
            }
          }
        )
      end
    end

    context 'when receive bad params' do
      let(:params) { { workout_plan_id: nil, exercise_schedules: [] } }

      it 'returns status bad_request' do
        post('/api/exercises_groups', params:, headers: headers(user: personal.user))
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end