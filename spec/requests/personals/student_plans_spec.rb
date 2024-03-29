# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Personals::StudentPlans', type: :request do
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

  describe 'GET /api/personal/student_plans/student/:student_id' do
    before(:each) do
      create(:student_plan, student:, plan:)
      get(
        "/api/personal/student_plans/student/#{student.id}",
        headers: headers(user: personal.user)
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

  describe 'GET /api/personal/student_plans/:id' do
    before(:each) do
      student_plan = create(:student_plan, student:, plan:)
      get(
        "/api/personal/student_plans/#{student_plan.id}",
        headers: headers(user: personal.user)
      )
    end

    context 'when params are ok' do
      let(:student_plan) { StudentPlan.last }

      it { expect(response).to have_http_status(:ok) }

      it 'returns created student_plan' do
        expect(response_body['student_plan']).to match(student_plan_json)
      end
    end
  end

  describe 'POST /api/personal/student_plans' do
    before(:each) do
      post('/api/personal/student_plans', params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          student_id: student.id,
          plan_id: plan.id,
          started_at: Date.current.to_date.to_s
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
          started_at: Date.current.to_s
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it do
        expect(response_body['errors']).to match(['A validação falhou: Aluno é obrigatório(a)'])
      end
    end
  end

  describe 'PUT/PATCH /api/personal/student_plans/:id' do
    let!(:student_plan) { create(:student_plan, plan:, student:) }

    before(:each) do
      put("/api/personal/student_plans/#{student_plan.id}", params:,
                                                            headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          finished_at: Date.current.to_date.to_s,
          status: :canceled
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
          finished_at: Date.current.to_date.to_s,
          status: nil
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it {
        expect(response_body['errors']).to match(['Status não pode ficar em branco'])
      }
    end
  end
end
