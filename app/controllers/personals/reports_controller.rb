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

    def new_students_relation
      students_relation = NewStudentsRelationReport.call(
        year: params[:year],
        personal: current_personal
      )

      render json: { students_relation: }, status: :ok
    end

    def current_month_invoicing
      invoice_value = Payment
                      .where(personal: current_personal)
                      .where('date >= ?', Date.current.beginning_of_month)
                      .where('date <= ?', Date.current.end_of_month)
                      .sum(:amount)

      render json: { invoice_value: }, status: :ok
    end

    def invoice_relation
      invoice_data = InvoiceByMonthRelationReport.call(
        year: params[:year],
        personal: current_personal
      )

      render json: { invoice_data: }, status: :ok
    end

    def student_plan_pendencies
      pendencies = StudentPlanPendenciesReport.call(personal: current_personal)

      render json: { student_plan_pendencies: pendencies }, status: :ok
    end
  end
end
