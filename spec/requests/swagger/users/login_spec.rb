# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Authenticate user' do
  path '/api/users/login' do
    post('authenticate user') do
      tags 'Authentication'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: :email },
          password: { type: :string, format: :password }
        },
        required: %w[email password]
      }

      response(200, 'successful') do
        let!(:create_user) { create(:user, email: 'some@email.com', password: '123123123') }
        let(:user) { { email: 'some@email.com', password: '123123123' } }

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
