# frozen_string_literal: true

class UsersController < ApplicationController
  def login
    token = Users::LoginService.new(
      email: login_params[:email],
      password: login_params[:password]
    ).call
    render json: { token: }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  rescue_from Users::Exceptions::InvalidCredentials do |e|
    render json: { errors: e.message }, status: :forbidden
  end
end
