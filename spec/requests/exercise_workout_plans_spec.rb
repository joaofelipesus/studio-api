# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExerciseWorkoutPlans', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:exercise_workout_plan_json) do
    {
      'id' => exercise_workout_plan.id,
      'exercise_id' => exercise_workout_plan.exercise_id,
      'workout_plan_id' => exercise_workout_plan.workout_plan_id,
      'rest' => exercise_workout_plan.rest,
      'repetitions' => exercise_workout_plan.repetitions,
      'exercise_sequence' => exercise_workout_plan.exercise_sequence
    }
  end

  describe 'GET /api/exercise_workout_plans' do
    let!(:create_exercise_workout_plans) { 3.times { create(:exercise_workout_plan) } }

    before(:each) { get('/api/exercise_workout_plans', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['exercise_workout_plans'].size).to match(3) }
  end

  describe 'GET /api/exercise_workout_plans/:id' do
    before(:each) do
      get("/api/exercise_workout_plans/#{id}", headers: headers(user: personal.user))
    end

    context 'when exercise_workout_plan exist' do
      let!(:exercise_workout_plan) { create(:exercise_workout_plan) }
      let(:id) { exercise_workout_plan.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['exercise_workout_plan']).to match(exercise_workout_plan_json) }
    end

    context 'when exercise workout plan dont exist' do
      let(:id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/exercise_workout_plans' do
    let!(:exercise) { create(:exercise) }
    let!(:workout_plan) { create(:workout_plan) }
    before(:each) do
      post('/api/exercise_workout_plans', params: params, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          'exercise_id' => exercise.id,
          'workout_plan_id' => workout_plan.id,
          'rest' => :thirty_seconds,
          'repetitions' => :pyramid,
          'exercise_sequence' => 1
        }
      end

      let(:exercise_workout_plan) { ExerciseWorkoutPlan.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created exercise' do
        expect(response_body['exercise_workout_plan']).to match(exercise_workout_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          'exercise_id' => nil,
          'workout_plan_id' => workout_plan.id,
          'rest' => :thirty_seconds,
          'repetitions' => :pyramid,
          'exercise_sequence' => 1
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Exercício é obrigatório(a)']) }
    end
  end

  describe 'PUT/PATCH /api/exercise_workout_plans/:id' do
    let(:exercise_workout_plan) { create(:exercise_workout_plan) }
    let(:id) { exercise_workout_plan.id }

    before(:each) do
      put("/api/exercise_workout_plans/#{id}", params: params,
                                               headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          'exercise_id' => exercise_workout_plan.exercise_id,
          'workout_plan_id' => exercise_workout_plan.workout_plan_id,
          'rest' => :thirty_seconds,
          'repetitions' => :pyramid,
          'exercise_sequence' => 1
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated exercise_workout_plan' do
        exercise_workout_plan.reload
        expect(response_body['exercise_workout_plan']).to match(exercise_workout_plan_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          'exercise_id' => exercise_workout_plan.exercise_id,
          'workout_plan_id' => exercise_workout_plan.workout_plan_id,
          'rest' => :thirty_seconds,
          'repetitions' => nil,
          'exercise_sequence' => 1
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Repetições não pode ficar em branco']) }
    end
  end
end
