# frozen_string_literal: true

RSpec.describe SchedulesQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:, name: 'Du') }

    before do
      # student = create(:student, personal:, name: 'Du')
      create(:schedule, personal:, student:, date: 1.day.ago.to_date)
      create(:schedule, personal:, student:, date: 1.day.ago.to_date)
      create(:schedule, personal:, student:, date: 2.days.ago.to_date)

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

    context 'when searching by date' do
      it 'renturns students which name matches with params[:date]' do
        params = {
          personal_id: personal.id,
          page: 1,
          date: 1.day.ago.to_date
        }
        expect(described_class.call(params:)[:schedules].size).to match(2)
        expect(described_class.call(params:)[:meta]).to match(
          {
            total_pages: 1,
            current_page: 1
          }
        )
      end
    end

    context 'when searching by student_id' do
      it 'renturns students which name matches with params[:student_id]' do
        params = {
          personal_id: personal.id,
          page: 1,
          student_id: student.id
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
end
