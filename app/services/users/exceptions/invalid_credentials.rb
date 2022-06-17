# frozen_string_literal: true

module Users
  module Exceptions
    class InvalidCredentials < StandardError
      def initialize
        super(I18n.t('messages.user.invalid_credentials'))
      end
    end
  end
end
