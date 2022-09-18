# frozen_string_literal: true

class ExercisesGroupsController < ApplicationController
  include Secure

  def create
    exercises_group = ExercisesGroups::CreateService.call(exercises_group_params)
    if exercises_group.valid?
      render_success(exercises_group, status: :created)
    else
      render json: {}, status: :bad_request
    end
  end

  def destroy
    ExercisesGroups::DestroyService.call(id: params[:id])
    render json: {}, status: :ok
  end

  private

  def exercises_group_params
    params.permit(
      :workout_plan_id,
      exercise_schedules: %i[exercise_id exercise_sequence rest repetitions]
    )
  end
end
