# frozen_string_literal: true

module Services
  module Users
    class Login
      # @param email [String]
      # @param password [String]
      def initialize(email:, password:)
        @email = email
        @password = password
      end

      # Check received user credentials and if it is valid return a JWT token.
      # @return String [String] encoded JWT token.
      # @raise [Services::Users::Exceptions::InvalidCredentials] when received email does't match
      #   with any
      #   confirmed and active user or received password doesn't match.
      def call
        return invalid_credentials unless user  # NOTE: maybe use & in only one clause ?
        return invalid_credentials unless user.authenticate(password)

        Services::Auth::JwtHandler.encode({ user_id: user.id, kind: user.kind })
      end

      private

      attr_reader :email, :password

      def user
        @user ||= User.find_by(email:, status: :confirmed)
      end

      def invalid_credentials
        raise Services::Users::Exceptions::InvalidCredentials
      end
    end
  end
end
