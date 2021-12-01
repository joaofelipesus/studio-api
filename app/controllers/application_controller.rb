# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate
    @current_user = Services::Auth::CreateSession.new(authorization: request.headers[:Authorization]).call
  end

  # Method used to handle create and update methods errors, defines a error return pattern.
  # @param [ApplicationRecord] application model.
  def render_error_messages(model)
    render json: { errors: model.errors.full_messages }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: {}, status: :not_found
  end

  # Handle authentication exceptions.
  rescue_from JWT::VerificationError, JWT::DecodeError do
    render json: {}, status: :unauthorized
  end

  def current_personal
    Personal.find_by(user: current_user)
  end

  # Render default index return.
  # @param registers [List<Model>] a list of a model.
  def render_all(registers)
    model_name = self.class.name.split('Controller').first.underscore
    locals = { model_name.to_sym => registers }
    render(
      "#{model_name}/index",
      formats: :json,
      status: :ok,
      locals: locals
    )
  end

  # Render default show return.
  # @param register [Model] active model object.
  # @param model [Symbol] symbol with model class name without capital chars.
  # @param status [Symbol] http status returned.
  def render_success(register, model:, status: :ok)
    locals = { model => register }
    render(
      "#{model}s/show",
      formats: :json,
      status: status,
      locals: locals
    )
  end
end
