# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api do
    post '/users/login', to: 'users#login', as: :login
    resources :exercises, only: %i[create update show index]
    resources :workout_plans, only: %i[create update show index]
    resources :exercise_workout_plans, only: %i[create update show index]
  end
end
