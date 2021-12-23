# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Create new schedule' do
  let!(:current_user) { create(:personal).user }
  let!(:student) { create(:student) }
  let!(:workout_plan) { create(:workout_plan) }

  path '/api/schedules' do
    post('create schedule') do
      tags 'Schedule'
      consumes 'application/json'
      parameter(
        name: :schedule,
        in: :body,
        schema: {
          type: :object,
          properties: {
            student_id: { type: :string },
            workout_plan_id: { type: :string },
            start_at: { type: :string },
            date: { type: :date, format: :date }
          },
          required: %w[student_id workout_plan_id start_at]
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
        let(:schedule) do
          {
            student_id: student.id,
            workout_plan_id: workout_plan.id,
            start_at: '19:00',
            date: Date.current
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
