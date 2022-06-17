# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    post 'e2e/setup', to: 'e2e_support#setup' if Rails.env.development? # e2e tests route.
    post '/users/login', to: 'users#login', as: :login
    resources :exercises, only: %i[create update show index]
    resources :workout_plans, only: %i[create update show index]
    resources :exercise_workout_plans, only: %i[create update show index]
    resources :students, only: %i[create update show index]
    resources :schedules, only: %i[create update show index]
    resources :muscular_groups, only: %i[index]
  end
end
