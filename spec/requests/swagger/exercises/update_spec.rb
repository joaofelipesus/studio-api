# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Update exercise' do
  let!(:current_user) { create(:user, :personal) }
  let!(:exercise_record) { create(:exercise) }

  path '/api/exercises/{id}' do
    put('Update exercise') do
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
        let(:exercise) do
          {
            name: 'NERV',
            muscular_group_id: exercise_record.muscular_group_id
          }
        end

        let(:id) { exercise_record.id }

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
