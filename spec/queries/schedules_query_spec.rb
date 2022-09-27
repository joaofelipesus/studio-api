# frozen_string_literal: true

RSpec.describe SchedulesQuery do
  describe '#call' do
    let(:personal) { create(:personal) }

    before do
      student = create(:student, personal:, name: 'Du')
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student:)
      create(:schedule, personal:, student:)

      other_personal_student = create(:student, name: 'Dudu')
      create(:schedule, student: other_personal_student)
      create(:schedule, student: other_personal_student)
    end

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
