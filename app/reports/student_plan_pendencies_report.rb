# frozen_string_literal: true

class StudentPlanPendenciesReport
  def initialize(personal:)
    @personal = personal
  end

  def self.call(personal:)
    new(personal:).call
  end

  def call
    pending_plans = StudentPlan
                    .includes(:payments)
                    .joins(:plan, :student)
                    .where(students: { personal_id: personal.id })
                    .pending
                    .uniq

    pending_plans.map do |student_plan|
      {
        id: student_plan.id,
        student: student_plan.student.name,
        pending_value: student_plan.pending_value,
        total_value: student_plan.plan.total_amount,
        plan: student_plan.plan.name
      }
    end
  end

  private

  attr_reader :personal
end
