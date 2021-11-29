# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Create new exercise' do
  let!(:current_user) { create(:user, kind: :personal) }
  # let(:headers) { authenticate(user: current_user) }
  let!(:muscular_group) { create(:muscular_group) }

  path '/api/exercises' do
    post('create exercise') do
      tags 'Exercise'
      consumes 'application/json'
      parameter(
        name: :exercise,
        in: :body,
        schema: {
          type: :object,
          properties: {
            name: { type: :string },
            muscular_group_id: { type: :string }
          },
          required: %w[name muscular_group_id]
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
        let(:exercise) do
          {
            name: 'NERV',
            muscular_group_id: muscular_group.id
          }
        end

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
