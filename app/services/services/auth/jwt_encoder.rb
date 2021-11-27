# frozen_string_literal: true

module Services
  module Auth
    class JwtEncoder
      def self.encode(payload)
        payload[:exp] = Time.now.to_i + 4 * 3600
        JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'))
      end
    end
  end
end
