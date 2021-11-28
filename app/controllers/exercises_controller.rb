# frozen_string_literal: true

class ExercisesController < ApplicationController
  # TODO: adicionar autenticacao
  # TODO: Rota create

  def create
    exercise = Exercise.new(exercise_params)
    if exercise.save
      render json: { exercise: exercise }, status: :created
    else
      render_error_messages(exercise)
    end
  end
end
