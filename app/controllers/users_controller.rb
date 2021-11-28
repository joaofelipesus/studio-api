# frozen_string_literal: true

class UsersController < ApplicationController
  def login
    token = Services::Users::Login.new(email: login_params[:email], password: login_params[:password]).call
    render json: { token: token }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  rescue_from Services::Users::Exceptions::InvalidCredentials do |e|
    render json: { message: e.message }, status: :forbidden
  end
end
