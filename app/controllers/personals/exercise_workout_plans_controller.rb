# frozen_string_literal: true

module Personals
  class ExerciseWorkoutPlansController < ApplicationController
    def index
      paginated_data = Services::Pagination::Index.new(
        klass: ExerciseWorkoutPlan,
        params:,
        order_by: { created_at: :desc }
      ).call
      render_all(paginated_data)
    end

    def show
      exercise_workout_plan = ExerciseWorkoutPlan.find(params[:id])
      render_success(exercise_workout_plan)
    end

    def create
      exercise_workout_plan = ExerciseWorkoutPlan.new(exercise_workout_plan_params)
      if exercise_workout_plan.save
        render_success(exercise_workout_plan, status: :created)
      else
        render_error_messages(exercise_workout_plan)
      end
    end

    def update
      exercise_workout_plan = ExerciseWorkoutPlan.find(params[:id])
      if exercise_workout_plan.update(exercise_workout_plan_params)
        render_success(exercise_workout_plan)
      else
        render_error_messages(exercise_workout_plan)
      end
    end

    private

    def exercise_workout_plan_params
      params.permit(
        :exercise_id,
        :workout_plan_id,
        :repetitions,
        :rest,
        :exercise_sequence
      )
    end
  end
end
