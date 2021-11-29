# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Update exercise workout plan' do
  let!(:current_user) { create(:user, :personal) }
  let!(:exercise_workout_plan_record) { create(:exercise_workout_plan) }

  path '/api/exercise_workout_plans/{id}' do
    put('Update exercise_workout_plan') do
      tags 'Exercise Workout Plan'
      consumes 'application/json'
      parameter(
        name: :exercise_workout_plan,
        in: :body,
        schema: {
          type: :object,
          properties: {
            workout_plan_id: { type: :string },
            exercise_id: { type: :string },
            repetitions: { type: :string },
            rest: { type: :string },
            exercise_sequence: { type: :integer }
          },
          required: %w[workout_plan_id exercise_id repetitions rest exercise_sequence]
        }
      )

      parameter(
        in: :path,
        type: :string,
        name: :id,
        required: true,
        description: 'ID'
      )

      parameter(
        in: :header,
        type: :string,
        name: :Authorization,
        required: true,
        description: 'Auth token'
      )

      security [Bearer: {}]

      response(200, 'successful') do
        let(:exercise_workout_plan) do
          {
            exercise_id: exercise_workout_plan_record.exercise_id,
            workout_plan_id: exercise_workout_plan_record.workout_plan_id,
            rest: :free,
            exercise_sequence: 1,
            repetitions: :pyramid
          }
        end

        let(:id) { exercise_workout_plan_record.id }

        let(:Authorization) { headers(user: current_user) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
