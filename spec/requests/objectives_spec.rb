# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Objetcives', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:objective_json) do
    {
      'id' => objective.id,
      'name' => objective.name
    }
  end

  describe 'GET /api/objectives' do
    let!(:create_objectives) { 3.times { create(:objective) } }

    before(:each) { get('/api/objectives', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['objectives'].size).to match(3) }
  end
end
