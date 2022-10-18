# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Personals::Exercises', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:exercise_json) do
    {
      'id' => exercise.id,
      'name' => exercise.name,
      'muscular_group_id' => exercise.muscular_group_id,
      'muscular_group' => { 'name' => exercise.muscular_group.name }
    }
  end

  describe 'GET /api/personal/exercises' do
    let!(:create_exercises) { 3.times { create(:exercise, personal:) } }

    before(:each) { get('/api/personal/exercises', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['exercises'].size).to match(3) }
    it { expect(response_body['total_pages']).to match(1) }
  end

  describe 'GET /api/personal/exercises/:id' do
    before(:each) do
      get("/api/personal/exercises/#{exercise_id}", headers: headers(user: personal.user))
    end

    context 'when exercise exist' do
      let!(:exercise) { create(:exercise, personal:) }
      let(:exercise_id) { exercise.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['exercise']).to match(exercise_json) }
    end

    context 'when exercise dont exist' do
      let(:exercise_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/personal/exercises' do
    let!(:muscular_group) { create(:muscular_group) }

    before(:each) do
      post('/api/personal/exercises', params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) { { name: 'Some name', muscular_group_id: muscular_group.id } }
      let(:exercise) { Exercise.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created exercise' do
        expect(response_body['exercise']).to match(exercise_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil, muscular_group_id: muscular_group.id } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'PUT/PATCH /api/personal/exercises/:id' do
    let!(:muscular_group) { create(:muscular_group) }
    let!(:exercise) { create(:exercise, personal:) }

    before(:each) do
      put("/api/personal/exercises/#{exercise.id}", params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) { { name: 'Some name', muscular_group_id: muscular_group.id } }

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated exercise' do
        exercise.reload
        expect(response_body['exercise']).to match(exercise_json)
      end
    end

    context 'when params has errors' do
      let(:params) { { name: nil, muscular_group_id: muscular_group.id } }

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'DELETE /api/personal/exercises/:id' do
    before(:each) do
      delete("/api/personal/exercises/#{exercise_id}", headers: headers(user: personal.user))
    end

    context 'when exercise exist' do
      let!(:exercise) { create(:exercise, personal:) }
      let(:exercise_id) { exercise.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(Exercise.count).to be(0) }
    end

    context 'when exercise dont exist' do
      let(:exercise_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
