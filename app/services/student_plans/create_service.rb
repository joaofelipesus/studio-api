# frozen_string_literal: true

module StudentPlans
  class CreateService
    INITIAL_STATUS = :progress

    def initialize(params:)
      @plan_id = params[:plan_id]
      @started_at = params[:started_at]
      @student_id = params[:student_id]
      @student_plan = StudentPlan.new
    end

    def self.call(params:)
      new(params:).call
    end

    def call
      @student_plan = StudentPlan.create!(student_plan_params)
      @student_plan
    rescue ActiveRecord::RecordInvalid => exception
      @student_plan.errors.add(:base, message: exception.message)
      @student_plan
    end

    private

    attr_reader :plan_id, :student_id, :started_at

    def student_plan_params
      {
        plan_id:,
        student_id:,
        started_at:,
        finished_at:,
        status: INITIAL_STATUS
      }
    end

    def finished_at
      started_at.to_date + plan.duration_in_months.months
    end

    def plan
      Plan.find(plan_id)
    end
  end
end
