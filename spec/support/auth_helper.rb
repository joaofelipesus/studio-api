# frozen_string_literal: true

module AuthHelper
  def headers(user:)
    { Authorization: "Bearer #{auth_token(user)}"}
  end

  def auth_token(user)
    Services::Auth::JwtHandler.encode({ user_id: user.id })
  end
end
