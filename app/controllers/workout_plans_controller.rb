# frozen_string_literal: true

class WorkoutPlansController < ApplicationController
  include Secure

  def index
    render(
      'workout_plans/index',
      formats: :json,
      locals: { paginated_data: paginated_workout_plans }
    )
  end

  def show
    workout_plan = WorkoutPlan.find(params[:id])
    render_success(workout_plan)
  end

  def create
    workout_plan = WorkoutPlan.new(workout_plan_params)
    if workout_plan.save
      render_success(workout_plan, status: :created)
    else
      render_error_messages(workout_plan)
    end
  end

  def update
    workout_plan = WorkoutPlan.find(params[:id])
    if workout_plan.update(workout_plan_params)
      render_success(workout_plan)
    else
      render_error_messages(workout_plan)
    end
  end

  private

  def workout_plan_params
    params.permit(
      :name
    ).merge(personal_id: current_personal.id)
  end

  def paginated_workout_plans
    WorkoutPlansQuery.call(
      params: {
        page: params[:page],
        personal_id: current_personal.id,
        name: params[:name],
        all: params[:all]
      }
    )
  end
end
