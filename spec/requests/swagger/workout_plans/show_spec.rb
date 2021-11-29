# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Show workout_plan' do
  let!(:current_user) { create(:personal).user }
  let!(:workout_plan_record) { create(:workout_plan) }

  path '/api/workout_plans/{id}' do
    get('Show workout_plan') do
      tags 'Workout Plan'
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
        let(:id) { workout_plan_record.id }

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
