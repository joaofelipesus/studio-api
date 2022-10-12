# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlansQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let!(:create_plans) { 3.times { create(:plan, personal:, name: Faker::Name.name) } }
    let!(:create_more_plans) { 2.times { create(:plan, name: Faker::Name.name) } }

    it 'renturns plans paginated and filtered by personal' do
      params = {
        personal_id: personal.id,
        page: 1
      }
      expect(described_class.call(params:)[:plans].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end
  end
end
