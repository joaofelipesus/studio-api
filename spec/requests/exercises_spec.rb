# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Exercises', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:exercise_json) do
    {
      'id' => exercise.id,
      'name' => exercise.name,
      'muscular_group_id' => exercise.muscular_group_id
    }
  end

  describe 'SHOW /api/exercises/:id' do
    before(:each) { get("/api/exercises/#{exercise_id}", headers: headers(user: personal.user)) }

    context 'when exercise exist' do
      let!(:exercise) { create(:exercise) }
      let(:exercise_id) { exercise.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['exercise']).to match(exercise_json) }
    end

    context 'when exercise dont exist' do
      let(:exercise_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/exercises' do
    let!(:muscular_group) { create(:muscular_group) }

    before(:each) { post('/api/exercises', params: params, headers: headers(user: personal.user)) }

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
end
