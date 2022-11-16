# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentPlanPendenciesReport do
  describe '#call' do
    it 'returns all student plans with pendencies' do
      personal = create(:personal)
      student = create(:student, personal:)
      plan = create(:plan, personal:, monthly_price: 100, duration_in_months: 12)
      student_plan = create(:student_plan, student:, plan:)
      create(:payment, student_plan:, amount: 100, personal:)
      expect(described_class.call(personal:)).to match(
        [
          {
            id: student_plan.id,
            student: student.name,
            pending_value: 1100.0,
            total_value: 1200.0,
            plan: plan.name
          }
        ]
      )
    end
  end
end
