# frozen_string_literal: true

RSpec.describe 'Personals::Students', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let!(:objective) { create(:objective) }
  let(:student_json) do
    {
      'id' => student.id,
      'personal_id' => student.personal_id,
      'name' => student.name,
      'objective_id' => objective.id,
      'active_plan' => student.active_plan?,
      'has_access' => student.has_access,
      'user' => {
        'email' => nil
      },
      'objective' => {
        'id' => objective.id,
        'name' => objective.name
      }
    }
  end

  describe 'GET /api/personal/students' do
    before(:each) do
      create(:student, objective:, personal:, name: 'Asuka')
      create(:student, objective:, personal:, name: 'Langley')
      create(:student, objective:, personal:, name: 'Sohryu')
      get('/api/personal/students', headers: headers(user: personal.user))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['students'].size).to match(3) }
  end

  describe 'GET /api/personal/students?all=true' do
    before(:each) do
      create(:student, objective:, personal:, name: 'Asuka')
      create(:student, objective:, personal:, name: 'Rei')
      create(:student, objective:, personal:, name: 'Shinji')
      get('/api/personal/students?all=true', headers: headers(user: personal.user))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['students'].size).to match(3) }
  end

  describe 'GET /api/personal/students/:id' do
    before(:each) do
      get("/api/personal/students/#{student_id}", headers: headers(user: personal.user))
    end

    context 'when student exist' do
      let!(:student) { create(:student, objective:, name: 'Asuka') }
      let(:student_id) { student.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['student']).to match(student_json) }
    end

    context 'when student dont exist' do
      let(:student_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/personal/students' do
    before(:each) { post('/api/personal/students', params:, headers: headers(user: personal.user)) }

    context 'when params are ok' do
      let(:params) do
        {
          name: Faker::JapaneseMedia::DragonBall.character,
          objective_id: objective.id
        }
      end
      let(:student) { Student.last }

      it { expect(response).to have_http_status(:created) }

      it 'returns created student' do
        expect(response_body['student']).to match(student_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        { name: nil, objective_id: objective.id }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'PUT/PATCH /api/personal/students/:id' do
    let!(:student) { create(:student, objective:, name: 'Shinji') }

    before(:each) do
      put("/api/personal/students/#{student.id}", params:, headers: headers(user: personal.user))
    end

    context 'when params are ok' do
      let(:params) do
        { name: 'Some new name' }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns updated student' do
        student.reload
        expect(response_body['student']).to match(student_json)
      end
    end

    context 'when params has errors' do
      let(:params) do
        { name: nil }
      end

      it { expect(response).to have_http_status(:bad_request) }

      it { expect(response_body['errors']).to match(['Nome não pode ficar em branco']) }
    end
  end

  describe 'DELETE /api/personal/students/:id' do
    before(:each) do
      delete("/api/personal/students/#{student_id}", headers: headers(user: personal.user))
    end

    context 'when student exist' do
      let!(:student) { create(:student, objective:, name: 'Rei') }
      let(:student_id) { student.id }

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when student dont exist' do
      let(:student_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/personal/students/give_access' do
    let(:params) { { student_id:, email: 'some@email.com' } }
    let!(:student) { create(:student, objective:, personal:, name: 'Rei') }

    before(:each) do
      post(
        '/api/personal/students/give_access',
        params:,
        headers: headers(user: personal.user)
      )
    end

    context 'when student exist' do
      let(:student_id) { student.id }

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when student dont exist' do
      let(:student_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /api/personal/students/:id/revoke_access' do
    let(:params) { { student_id: } }
    let(:user) { create(:user, kind: :student) }
    let!(:student) { create(:student, objective:, personal:, name: 'Rei', user:, has_access: true) }

    before(:each) do
      put(
        "/api/personal/students/#{student_id}/revoke_access",
        params:,
        headers: headers(user: personal.user)
      )
    end

    context 'when student exist' do
      let(:student_id) { student.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(student.reload.has_access).to be_falsey }
    end

    context 'when student dont exist' do
      let(:student_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
