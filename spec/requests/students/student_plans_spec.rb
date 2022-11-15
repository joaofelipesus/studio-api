# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students::StudentPlans', type: :request do
  describe 'GET shcedules/index' do
    let(:response_body) { JSON.parse(response.body) }
    let!(:personal) { create(:personal) }
    let!(:plan) { create(:plan, personal:) }
    let(:user) { create(:user, kind: :student) }
    let!(:student) { create(:student, name: 'Du', personal:, has_access: true, user:) }
    let(:student_plan_json) do
      {
        'id' => student_plan.id,
        'plan_id' => student_plan.plan_id,
        'student_id' => student_plan.student_id,
        'started_at' => student_plan.started_at.to_s,
        'finished_at' => student_plan.finished_at.to_s,
        'status' => student_plan.status,
        'payment_status' => student_plan.payment_status,
        'plan' => {
          'id' => plan.id,
          'name' => plan.name,
          'monthly_price' => plan.monthly_price,
          'duration_in_months' => plan.duration_in_months
        },
        'payments' => []
      }
    end

    describe 'GET /api/student/student_plans' do
      before(:each) do
        create(:student_plan, student:, plan:)
        get(
          "/api/student/student_plans?student_id=#{student.id}&all=true",
          headers: headers(user:)
        )
      end

      context 'when params are ok' do
        let(:student_plan) { StudentPlan.last }

        it { expect(response).to have_http_status(:ok) }

        it 'returns created student_plan' do
          expect(response_body['student_plans'].size).to be(1)
        end
      end
    end
  end
end
