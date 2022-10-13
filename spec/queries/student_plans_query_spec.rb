# frozen_string_literal: true

RSpec.describe StudentPlansQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:, name: 'Some cool name') }
    let(:second_student) { create(:student, personal:, name: 'Some other cool name') }
    let(:anual_plan) { create(:plan, name: 'Anual', duration_in_months: 12, personal:) }
    let(:semestral_plan) { create(:plan, name: 'Semestral', duration_in_months: 6, personal:) }
    let(:mensal_plan) { create(:plan, name: 'Mensal', duration_in_months: 1, personal:) }

    before do
      create(:student_plan, student:, plan: anual_plan, status: :canceled)
      create(:student_plan, student:, plan: semestral_plan, status: :finished)
      create(:student_plan, student:, plan: mensal_plan, status: :progress)
      create(:student_plan, student: second_student, plan: mensal_plan, status: :progress)
      create(:student_plan, student: second_student, plan: anual_plan, status: :canceled)
    end

    it 'renturns student paginated' do
      params = {
        student_id: student.id,
        page: 1
      }
      expect(described_class.call(params:)[:student_plans].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end
  end
end
