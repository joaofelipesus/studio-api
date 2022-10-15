# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentsQuery do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:, name: 'Some cool name') }
    # let(:second_student) { create(:student, personal:, name: 'Some other cool name') }
    let(:plan) { create(:plan, name: 'Anual', duration_in_months: 12, personal:) }
    # let(:semestral_plan) { create(:plan, name: 'Semestral', duration_in_months: 6, personal:) }
    # let(:mensal_plan) { create(:plan, name: 'Mensal', duration_in_months: 1, personal:) }
    let(:student_plan) { create(:student_plan, plan:, student:) }

    before do
      # create(:student_plan, student:, plan: anual_plan, status: :canceled)
      # create(:student_plan, student:, plan: semestral_plan, status: :finished)
      # create(:student_plan, student:, plan: mensal_plan, status: :progress)
      # create(:student_plan, student: second_student, plan: mensal_plan, status: :progress)
      # create(:student_plan, student: second_student, plan: anual_plan, status: :canceled)
      create(:payment, student_plan:, personal:)
      create(:payment, student_plan:, personal:)
      create(:payment)
    end

    it 'renturns payments paginated' do
      params = { page: 1 }
      expect(described_class.call(params:)[:payments].size).to match(3)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end

    it 'filters by personal' do
      params = { page: 1, personal_id: personal.id }
      expect(described_class.call(params:)[:payments].size).to match(2)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end

    it 'filters by student_plan_id' do
      params = { page: 1, personal_id: personal.id, student_plan_id: student_plan.id }
      expect(described_class.call(params:)[:payments].size).to match(2)
      expect(described_class.call(params:)[:meta]).to match(
        {
          total_pages: 1,
          current_page: 1
        }
      )
    end
  end
end
