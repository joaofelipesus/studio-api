# frozen_string_literal: true

RSpec.describe 'Students', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let!(:objective) { create(:objective) }
  let(:student_json) do
    {
      'id' => student.id,
      'personal_id' => student.personal_id,
      'name' => student.name,
      'objective_id' => objective.id,
      'objective' => {
        'id' => objective.id,
        'name' => objective.name
      }
    }
  end

  describe 'GET /api/students' do
    let!(:create_students) { 3.times { create(:student, objective:, personal:) } }

    before(:each) { get('/api/students', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['students'].size).to match(3) }
  end

  describe 'GET /api/students?all=true' do
    let!(:create_students) { 11.times { create(:student, personal:) } }

    before(:each) { get('/api/students?all=true', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['students'].size).to match(11) }
  end

  describe 'GET /api/students/:id' do
    before(:each) { get("/api/students/#{student_id}", headers: headers(user: personal.user)) }

    context 'when student exist' do
      let!(:student) { create(:student, objective:) }
      let(:student_id) { student.id }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response_body['student']).to match(student_json) }
    end

    context 'when student dont exist' do
      let(:student_id) { '1q2w3e4r' }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/students' do
    before(:each) { post('/api/students', params:, headers: headers(user: personal.user)) }

    context 'when params are ok' do
      let(:params) do
        {
          name: Faker::Games::Zelda.unique.character,
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

  describe 'PUT/PATCH /api/students/:id' do
    let!(:student) { create(:student, objective:) }

    before(:each) do
      put("/api/students/#{student.id}", params:, headers: headers(user: personal.user))
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
end
