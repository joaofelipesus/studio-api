# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Show exercise workout plan' do
  let!(:current_user) { create(:user, :personal) }
  let!(:exercise_workout_plan_record) { create(:exercise_workout_plan) }

  path '/api/exercise_workout_plans/{id}' do
    get('Show exercise workout plan') do
      tags 'Exercise Workout Plan'
      consumes 'application/json'

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
