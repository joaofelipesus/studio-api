# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Plans', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:plan_json) do
    {
      'id' => plan.id,
      'name' => plan.name,
      'price' => plan.price,
      'duration_in_months' => plan.duration_in_months
    }
  end

  describe 'GET /api/plans' do
    let!(:create_plans) { 3.times { create(:plan, personal:) } }

    before(:each) { get('/api/plans', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['plans'].size).to match(3) }
    it { expect(response_body['total_pages']).to match(1) }
  end

  describe 'GET /api/plans/:id' do
    before(:each) { get("/api/plans/#{plan_id}", headers: headers(user: personal.user)) }

    context 'when plan exist' do
      let!(:plan) { create(:plan, personal:) }
      let(:plan_id) { plan.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['plan']).to match(plan_json) }
    end

    context 'when plan dont exist' do
      let(:plan_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/plans' do
    before(:each) { post('/api/plans', params:, headers: headers(user: personal.user)) }

    context 'when params are ok' do
      let(:params) { { name: 'Some name', price: 300.0, duration_in_months: 6 } }
      let(:plan) { Plan.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created plan' do
        expect(response_body['plan']).to match(plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil, price: 300, duration_in_months: 999 } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'PUT/PATCH /api/plans/:id' do
    let!(:plan) { create(:plan, personal:) }

    before(:each) do
      put("/api/plans/#{plan.id}", params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) { { name: 'Some name', price: 400.0, duration_in_months: 12 } }

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated plan' do
        plan.reload
        expect(response_body['plan']).to match(plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil, price: 300.0, duration_in_months: 6 } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end
end