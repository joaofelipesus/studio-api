# frozen_string_literal: true

module Personals
  class ReportsController < ApplicationController
    def students_count
      render json: { students_count: Student.where(personal: current_personal).count }, status: :ok
    end

    def students_without_active_plan_count
      students_count = Student
                       .where(personal: current_personal)
                       .where.not('id IN(?)', StudentPlan.progress.pluck(:student_id))
                       .count

      render json: { students_without_active_plan_count: students_count }, status: :ok
    end

    def students_plan_relation
      students_relation = StudentPlan
                          .joins(:plan, :student)
                          .where(students: { personal_id: current_personal.id })
                          .progress
                          .group('plans.name')
                          .count

      render json: { students_plan_relation: students_relation }, status: :ok
    end
  end
end
