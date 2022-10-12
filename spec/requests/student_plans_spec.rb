# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StudentPlans', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let!(:plan) { create(:plan, personal:) }
  let!(:student) { create(:student, name: 'Du', personal:) }
  let(:student_plan_json) do
    {
      'id' => student_plan.id,
      'plan_id' => student_plan.plan_id,
      'student_id' => student_plan.student_id,
      'started_at' => student_plan.started_at.to_s,
      'status' => student_plan.status
    }
  end

  describe 'POST /api/student_plans' do
    # let!(:plan) { create(:plan, personal:) }
    # let!(:student) { create(:student, name: 'Du', personal:) }

    before(:each) { post('/api/student_plans', params:, headers: headers(user: personal.user)) }

    context 'when params are ok' do
      let(:params) do
        {
          student_id: student.id,
          plan_id: plan.id,
          started_at: Date.current.to_date.to_s,
          status: :progress
        }
      end

      let(:student_plan) { StudentPlan.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created student_plan' do
        expect(response_body['student_plan']).to match(student_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          student_id: nil,
          plan_id: plan.id,
          started_at: Date.current,
          status: :progress
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Aluno é obrigatório(a)']) }
    end
  end

  describe 'PUT/PATCH /api/student_plans/:id' do
    let!(:student_plan) { create(:student_plan, plan:, student:) }

    before(:each) do
      put("/api/student_plans/#{student_plan.id}", params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          student_id: student.id,
          plan_id: plan.id,
          started_at: Date.current.to_date.to_s,
          status: :progress
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated student_plan' do
        student_plan.reload
        expect(response_body['student_plan']).to match(student_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          student_id: student.id,
          plan_id: nil,
          started_at: Date.current.to_date.to_s,
          status: :progress
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it {
        expect(response_body['errors']).to match(['Plano é obrigatório(a)'])
      }
    end
  end
end
