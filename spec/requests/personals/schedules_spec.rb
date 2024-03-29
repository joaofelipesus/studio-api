# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Personals::Schedules', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  # rubocop:disable Metrics/BlockLength
  let(:schedule_json) do
    {
      'id' => schedule.id,
      'workout_plan_id' => schedule.workout_plan_id,
      'student_id' => schedule.student_id,
      'start_at' => schedule.start_at,
      'date' => schedule.date.to_s,
      'status' => schedule.status,
      'personal_id' => schedule.personal_id,
      'student' => {
        'id' => schedule.student.id,
        'personal_id' => schedule.student.personal_id,
        'name' => schedule.student.name,
        'objective_id' => schedule.student.objective_id,
        'active_plan' => schedule.student.active_plan?,
        'has_access' => schedule.student.has_access,
        'user' => {
          'email' => nil
        },
        'objective' => {
          'id' => schedule.student.objective_id,
          'name' => schedule.student.objective.name
        }
      },
      'workout_plan' => {
        'id' => schedule.workout_plan.id,
        'name' => schedule.workout_plan.name,
        'personal_id' => schedule.workout_plan.personal_id,
        'exercises_groups' => []
      }
    }
  end
  # rubocop:enable Metrics/BlockLength

  describe 'GET /api/personal/schedules' do
    before(:each) do
      student = create(:student, name: 'Rock Lee')
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student:)
      get('/api/personal/schedules', headers: headers(user: personal.user))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['schedules'].size).to match(3) }
  end

  describe 'GET /api/personal/schedules/:id' do
    before(:each) do
      get("/api/personal/schedules/#{schedule_id}", headers: headers(user: personal.user))
    end

    context 'when schedule exist' do
      let!(:schedule) { create(:schedule, personal:) }
      let(:schedule_id) { schedule.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['schedule']).to match(schedule_json) }
    end

    context 'when schedule dont exist' do
      let(:schedule_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/personal/schedules' do
    let!(:workout_plan) { create(:workout_plan) }
    let!(:student) { create(:student, name: 'Du') }

    before(:each) do
      post('/api/personal/schedules', params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          student_id: student.id,
          workout_plan_id: workout_plan.id,
          start_at: '19:00',
          date: Date.current
        }
      end

      let(:schedule) { Schedule.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created schedule' do
        expect(response_body['schedule']).to match(schedule_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          student_id: nil,
          workout_plan_id: workout_plan.id,
          start_at: '18:45',
          date: Date.current
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Aluno é obrigatório(a)']) }
    end
  end

  describe 'PUT/PATCH /api/personal/schedules/:id' do
    let!(:schedule) { create(:schedule, personal:) }

    before(:each) do
      put("/api/personal/schedules/#{schedule.id}", params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        {
          student_id: schedule.student_id,
          workout_plan_id: schedule.workout_plan_id,
          start_at: '19:00',
          date: Date.current
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated schedule' do
        schedule.reload
        expect(response_body['schedule']).to match(schedule_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        {
          student_id: schedule.student_id,
          workout_plan_id: schedule.workout_plan_id,
          start_at: nil
        }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it {
        expect(response_body['errors']).to match(['Horário de início não pode ficar em branco'])
      }
    end
  end

  describe 'DELETE /api/personal/schedules/:id' do
    before(:each) do
      delete("/api/personal/schedules/#{schedule_id}", headers: headers(user: personal.user))
    end

    context 'when schedule exist' do
      let!(:schedule) { create(:schedule, personal:) }
      let(:schedule_id) { schedule.id }

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when schedule dont exist' do
      let(:schedule_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
