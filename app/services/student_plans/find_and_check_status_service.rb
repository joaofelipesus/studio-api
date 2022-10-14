# frozen_string_literal: true

module StudentPlans
  class FindAndCheckStatusService
    def initialize(student)
      @student = student
    end

    def self.call(student)
      new(student).call
    end

    def call
      progress_plans.each do |student_plan|
        next if student_plan.canceled? || student_plan.finished?

        student_plan.update(status: :finished) if Date.current > student_plan.finished_at
      end

      !progress_plans.empty?
    end

    private

    attr_reader :student

    def progress_plans
      student.student_plans.progress
    end
  end
end
