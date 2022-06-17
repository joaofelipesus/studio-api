# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Update schedule' do
  let!(:personal) { create(:personal) }
  let!(:current_user) { personal.user }
  let!(:schedule_record) { create(:schedule, personal: personal) }

  path '/api/schedules/{id}' do
    put('Update schedule') do
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
            date: { type: :string, format: :date }
          },
          required: %w[student_id workout_plan_id start_at]
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
        let(:schedule) do
          {
            student_id: schedule_record.student_id,
            workout_plan_id: schedule_record.workout_plan_id,
            start_at: '19:30',
            date: Date.current
          }
        end

        let(:id) { schedule_record.id }

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
