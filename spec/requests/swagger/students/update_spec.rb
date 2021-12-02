# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Update student' do
  let!(:current_user) { create(:personal).user }
  let!(:student_record) { create(:student) }

  path '/api/students/{id}' do
    put('Update student') do
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
        let(:student) do
          {
            user_attributes: {
              email: 'asuka@nerv.com',
              name: 'Name Langley'
            }
          }
        end

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
