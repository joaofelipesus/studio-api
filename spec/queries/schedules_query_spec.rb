# frozen_string_literal: true

RSpec.describe SchedulesQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let!(:create_schedules) { 3.times { create(:schedule, personal:) } }
    let!(:create_more_schedule) { 2.times { create(:schedule) } }

    it 'renturns schedules paginated' do
      params = {
        personal_id: personal.id,
        page: 1
      }
      expect(described_class.call(params:)[:schedules].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end
  end
end
