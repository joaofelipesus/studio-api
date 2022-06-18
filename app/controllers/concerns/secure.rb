# frozen_string_literal: true

module Secure
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate

    def authenticate
      @current_user = Services::Auth::CreateSession.new(
        authorization: request.headers[:Authorization]
      ).call
    end

    # Handle authentication exceptions.
    rescue_from JWT::VerificationError, JWT::DecodeError do
      render json: {}, status: :unauthorized
    end
  end
end
