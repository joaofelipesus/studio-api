# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students::Schedules', type: :request do
  describe 'GET /index' do
    before(:each) do
      personal = create(:personal)
      user = create(:user, kind: :student)
      student = create(:student, name: 'Konan', has_access: true, user:)
      other_student = create(:student, name: 'Pain')
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student: other_student)
      get('/api/student/schedules', headers: headers(user:))
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body['schedules'].size).to match(2) }
  end
end
