# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Create new workout_plan' do
  let!(:current_user) { create(:personal).user }

  path '/api/workout_plans' do
    post('create workout plan') do
      tags 'Workout Plan'
      consumes 'application/json'
      parameter(
        name: :workout_plan,
        in: :body,
        schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: %w[name]
        }
      )

      parameter(
        in: :header,
        type: :string,
        name: :Authorization,
        required: true,
        description: 'Auth token'
      )

      security [Bearer: {}]

      response(201, 'successful') do
        let(:workout_plan) { { name: Faker::Games::Zelda.character } }

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
