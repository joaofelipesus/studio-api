# frozen_string_literal: true

class UsersController < ApplicationController
  def login
    user = User.find_by(email: login_params[:email])
    return render json: { message: I18n.t('messages.invalid_credentials') }, status: :unauthorized unless user
    if user.password == login_params[:password]
      render json: {}, status: :ok
    else
      render json: { message: I18n.t('messages.invalid_credentials') }, status: :unauthorized unless user
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
