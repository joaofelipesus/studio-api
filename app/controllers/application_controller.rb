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
  # @param paginated_data [List<Model>] a list of a model.
  def render_all(paginated_data)
    render(
      "#{model_name}s/index",
      formats: :json,
      status: :ok,
      locals: paginated_data
    )
  end

  # Render default show return.
  # @param register [Model] active model object.
  # @param status [Symbol] http status returned.
  def render_success(register, status: :ok)
    locals = { model_name.to_sym => register }
    render(
      "#{model_name}s/show",
      formats: :json,
      status: status,
      locals: locals
    )
  end

  def model_class_name
    self.class.name.split('Controller').first[...-1]
  end

  def model_name
    model_class_name.underscore
  end

  # def setup_locals(registers, paginate)
  #   if paginate
  #     total_pages = model_class_name.constantize.page(1).total_pages
  #     { "#{model_name}s".to_sym => registers, total_pages: total_pages }
  #   else
  #     { "#{model_name}s".to_sym => registers }
  #   end
  # end
end
