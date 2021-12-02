# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Create new student' do
  let!(:current_user) { create(:personal).user }

  path '/api/students' do
    post('create student') do
      tags 'Student'
      consumes 'application/json'
      parameter(
        name: :student,
        in: :body,
        schema: {
          type: :object,
          properties: {
            user_attributes: {
              type: :object,
              in: :body,
              properties: {
                email: { type: :string, format: :email },
                name: { type: :string }
              }
            }
          },
          required: %w[user_attributes]
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
        let(:student) do
          {
            user_attributes: {
              email: 'asuka@nerv.com',
              name: 'Name Langley'
            }
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
