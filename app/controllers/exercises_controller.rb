# frozen_string_literal: true

class ExercisesController < ApplicationController
  include Secure
  before_action :set_exercise, only: %i[show update destroy]

  def index
    render('exercises/index', formats: :json, locals: { paginated_data: paginated_exercises })
  end

  def show
    render_success(@exercise)
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
    if @exercise.update(exercise_params)
      render_success(@exercise)
    else
      render_error_messages(@exercise)
    end
  end

  def destroy
    @exercise.destroy
    render(json: {}, status: :ok)
  end

  private

  def exercise_params
    params.permit(
      :name,
      :muscular_group_id
    ).merge(personal_id: current_personal.id)
  end

  def paginated_exercises
    ExercisesQuery.call(
      params: {
        page: params[:page],
        personal_id: current_personal.id,
        name: params[:name]
      }
    )
  end

  def set_exercise
    @exercise = Exercise.find_by!(id: params[:id], personal_id: current_personal.id)
  end
end
