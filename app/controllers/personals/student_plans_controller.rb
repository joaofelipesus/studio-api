# frozen_string_literal: true

module Personals
  class StudentPlansController < ApplicationController
    before_action :set_student_plan, only: %i[update show]

    def student_plans
      render('personals/student_plans/index', formats: :json, locals: { paginated_data: plans })
    end

    def show
      render_success(@student_plan)
    end

    def create
      student_plan = StudentPlans::CreateService.call(params: create_params)
      if student_plan.id
        render_success(student_plan, status: :created)
      else
        render_error_messages(student_plan)
      end
    end

    def update
      if @student_plan.update(update_params)
        render_success(@student_plan)
      else
        render_error_messages(@student_plan)
      end
    end

    private

    def set_student_plan
      @student_plan = StudentPlan.includes(:payments).find(params[:id])
    end

    def update_params
      params.permit(
        :finished_at,
        :status
      )
    end

    def create_params
      params.permit(
        :student_id,
        :plan_id,
        :started_at
      )
    end

    def plans
      StudentPlansQuery.call(
        params: {
          personal_id: current_personal.id,
          student_id: params[:student_id],
          all: params[:all]
        }
      )
    end
  end
end
