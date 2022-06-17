# frozen_string_literal: true

module Services
  module Auth
    class JwtHandler
      def self.encode(payload)
        payload[:exp] = Time.now.to_i + (4 * 3600)
        JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'))
      end

      def self.decode(token)
        decoded = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'))[0]
        HashWithIndifferentAccess.new decoded
      end
    end
  end
end
