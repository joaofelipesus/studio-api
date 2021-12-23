# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
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
        'user' => {
          'name' => schedule.student.user.name,
          'email' => schedule.student.user.email
        }
      },
      'workout_plan' => {
        'id' => schedule.workout_plan.id,
        'name' => schedule.workout_plan.name,
        'personal_id' => schedule.workout_plan.personal_id
      }
    }
  end

  describe 'GET /api/schedules' do
    let!(:create_schedules) { 3.times { create(:schedule, personal: personal) } }

    before(:each) { get('/api/schedules', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['schedules'].size).to match(3) }
  end

  describe 'GET /api/schedules/:id' do
    before(:each) { get("/api/schedules/#{schedule_id}", headers: headers(user: personal.user)) }

    context 'when schedule exist' do
      let!(:schedule) { create(:schedule) }
      let(:schedule_id) { schedule.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['schedule']).to match(schedule_json) }
    end

    context 'when schedule dont exist' do
      let(:schedule_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/schedules' do
    let!(:workout_plan) { create(:workout_plan) }
    let!(:student) { create(:student) }

    before(:each) { post('/api/schedules', params: params, headers: headers(user: personal.user)) }

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

  describe 'PUT/PATCH /api/schedules/:id' do
    let!(:schedule) { create(:schedule) }

    before(:each) { put("/api/schedules/#{schedule.id}", params: params, headers: headers(user: personal.user)) }

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

      it { expect(response_body['errors']).to match(['Horário de início não pode ficar em branco']) }
    end
  end
end
