# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MuscularGroups', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let!(:personal) { create(:personal) }
  let(:muscular_group_json) do
    {
      'id' => muscular_group.id,
      'name' => muscular_group.name
    }
  end

  describe 'GET /api/muscular_groups' do
    let!(:create_muscular_groups) { 3.times { create(:muscular_group) } }

    before(:each) { get('/api/muscular_groups', headers: headers(user: personal.user)) }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response_body['muscular_groups'].size).to match(3) }
  end
end
