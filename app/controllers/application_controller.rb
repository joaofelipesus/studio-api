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
end
