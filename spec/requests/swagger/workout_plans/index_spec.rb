# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'List workout plans' do
  let!(:current_user) { create(:personal).user }

  path '/api/workout_plans' do
    get('List workout_plans') do
      tags 'Workout Plan'
      consumes 'application/json'

      parameter(
        in: :header,
        type: :string,
        name: :Authorization,
        required: true,
        description: 'Auth token'
      )

      security [Bearer: {}]

      response(200, 'successful') do
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
