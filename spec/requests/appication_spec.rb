# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application' do
  describe 'authenticate' do
    context 'when received token has invalid format' do
      let!(:exercise) { create(:exercise) }
      it 'returns status unauthorized' do
        get("/api/exercises/#{exercise.id}", headers: { Authorization: '1q2w3e4r' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
