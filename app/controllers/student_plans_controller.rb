# frozen_string_literal: true

class StudentPlansController < ApplicationController
  include Secure

  before_action :set_student_plan, only: %i[update]

  def student_plans
    render('student_plans/index', formats: :json, locals: { paginated_data: plans })
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
    @student_plan = StudentPlan.find(params[:id])
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
