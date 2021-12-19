# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api do
    post '/users/login', to: 'users#login', as: :login
    resources :exercises, only: %i[create update show index]
    resources :workout_plans, only: %i[create update show index]
    resources :exercise_workout_plans, only: %i[create update show index]
    resources :students, only: %i[create update show index]
    resources :schedules, only: %i[create update show index]
    resources :muscular_groups, only: %i[index]
    if Rails.env.development?
      post 'e2e/setup', to: 'e2e_support#setup'
    end
  end
end
