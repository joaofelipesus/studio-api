# frozen_string_literal: true

module Services
  module Users
    module Exceptions
      class InvalidCredentials < StandardError
        def initialize
          super(I18n.t('messages.user.invalid_credentials'))
        end
      end
    end
  end
end
