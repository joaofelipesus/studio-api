# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :authenticate

  def index
    paginated_data = Services::Pagination::Index.new(klass: Exercise, params: params).call
    render_all(paginated_data)
  end

  def show
    exercise = Exercise.find(params[:id])
    render_success(exercise)
  end

  def create
    exercise = Exercise.new(exercise_params)
    if exercise.save
      render_success(exercise, status: :created)
    else
      render_error_messages(exercise)
    end
  end

  def update
    exercise = Exercise.find(params[:id])
    if exercise.update(exercise_params)
      render_success(exercise)
    else
      render_error_messages(exercise)
    end
  end

  private

  def exercise_params
    params.permit(
      :name,
      :muscular_group_id
    )
  end
end
