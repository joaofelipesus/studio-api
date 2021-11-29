# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :authenticate

  def index
    exercises = Exercise.all.order(:name).page(params[:page])
    render_all(exercises, model: :exercise)
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

  def render_success(exercise, status: :ok)
    render('exercises/show', formats: :json, locals: { exercise: exercise }, status: status)
  end
end
