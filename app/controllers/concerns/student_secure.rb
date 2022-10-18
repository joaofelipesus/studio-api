# frozen_string_literal: true

module StudentSecure
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate

    def authenticate
      @current_user = Services::Auth::CreateSession.new(
        authorization: request.headers[:Authorization]
      ).call

      raise WrongUserKindError unless @current_user.student?
    end

    # Handle authentication exceptions.
    rescue_from JWT::VerificationError, JWT::DecodeError, WrongUserKindError do
      render json: {}, status: :unauthorized
    end
  end
end
