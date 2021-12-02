# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Show student' do
  let!(:current_user) { create(:user, :personal) }
  let!(:student_record) { create(:student) }

  path '/api/students/{id}' do
    get('Show student') do
      tags 'Student'
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
        let(:id) { student_record.id }

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
