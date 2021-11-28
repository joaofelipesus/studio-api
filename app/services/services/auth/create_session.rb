# frozen_string_literal: true

module Services
  module Auth
    class CreateSession
      # Process JWT token received and if it is valid return a User object, otherwise raises one exception
      def initialize(authorization:)
        @authorization = authorization
      end

      # @return [User]
      # @throws [JWT::VerificationError] jwt exception.
      # @throws [JWT::DecodeError] when received token is invalid.
      def call
        User.find(decoded_token[:user_id])
      end

      private

      attr_reader :authorization

      def decoded_token
        token = authorization.split(' ').last
        Services::Auth::JwtHandler.decode(token)
      end
    end
  end
end
