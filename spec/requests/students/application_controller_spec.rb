# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application' do
  describe 'authenticate' do
    let(:user) { create(:user, kind: :student) }
    let!(:student) { create(:student, user:) }

    context 'when received token has invalid format' do
      it 'returns status unauthorized' do
        get('/api/student/schedules', headers: { Authorization: '1q2w3e4r' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'token is valid but from wrong user kind' do
      it 'returns status unauthorized' do
        personal = create(:personal)
        get('/api/student/schedules', headers: headers(user: personal.user))
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
