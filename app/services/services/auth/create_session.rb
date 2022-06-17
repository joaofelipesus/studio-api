# frozen_string_literal: true

module Services
  module Auth
    class CreateSession
      # Process JWT token received and if it is valid return a User object, otherwise raises one
      #   exception
      def initialize(authorization:)
        @authorization = authorization
      end

      # @return [User]
      # @throws [JWT::VerificationError] jwt exception.
      # @throws [JWT::DecodeError] when received token is invalid.
      def call
        @user = User.find(decoded_token[:user_id])
        track_login if user
        user
      end

      private

      attr_reader :authorization, :user

      def decoded_token
        token = authorization.split.last
        Services::Auth::JwtHandler.decode(token)
      end

      def track_login
        user.update(last_login: DateTime.current)
      end
    end
  end
end
