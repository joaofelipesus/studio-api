# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Personals::WorkoutPlans', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:workout_plan_json) do
    {
      'id' => workout_plan.id,
      'name' => workout_plan.name,
      'personal_id' => workout_plan.personal_id,
      'exercises_groups' => []
    }
  end

  describe 'GET /api/personal/workout_plans' do
    let!(:create_workout_plans) { 3.times { create(:workout_plan, personal:) } }

    before(:each) { get('/api/personal/workout_plans', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['workout_plans'].size).to match(3) }
  end

  describe 'GET /api/personal/workout_plans?all=true' do
    let!(:create_workout_plans) { 3.times { create(:workout_plan, personal:) } }

    before(:each) do
      get('/api/personal/workout_plans?all=true', headers: headers(user: personal.user))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['workout_plans'].size).to match(3) }
  end

  describe 'GET /api/personal/workout_plans/:id' do
    before(:each) do
      get("/api/personal/workout_plans/#{workout_plan_id}", headers: headers(user: personal.user))
    end

    context 'when exercise exist' do
      let!(:workout_plan) { create(:workout_plan) }
      let(:workout_plan_id) { workout_plan.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['workout_plan']).to match(workout_plan_json) }
    end

    context 'when exercise dont exist' do
      let(:workout_plan_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/personal/workout_plans' do
    let(:workout_plan) { WorkoutPlan.last }

    before(:each) do
      post('/api/personal/workout_plans', params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) { { name: 'Some name' } }

      it { expect(response).to have_http_status(:created) }

      it 'returns created workout_plan' do
        expect(response_body['workout_plan']).to match(workout_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'PUT/PATCH /api/personal/workout_plans/:id' do
    let!(:workout_plan) { create(:workout_plan) }

    before(:each) do
      put(
        "/api/personal/workout_plans/#{workout_plan.id}",
        params:,
        headers: headers(user: personal.user)
      )
    end

    context 'when params are ok' do
      let(:params) { { name: 'Some name' } }

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated workout_plan' do
        workout_plan.reload
        expect(response_body['workout_plan']).to match(workout_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end
end
