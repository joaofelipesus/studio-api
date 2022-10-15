# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    post 'e2e/setup', to: 'e2e_support#setup' if Rails.env.development? # e2e tests route.
    post '/users/login', to: 'users#login', as: :login
    resources :exercises, only: %i[create update show index destroy]
    resources :workout_plans, only: %i[create update show index]
    resources :exercise_workout_plans, only: %i[create update show index]
    resources :students, only: %i[create update show index destroy]
    resources :schedules, only: %i[create update show index destroy]
    resources :muscular_groups, only: %i[index]
    resources :objectives, only: %i[index]
    resources :exercises_groups, only: %i[create destroy show]
    resources :plans, only: %i[create update index show]
    resources :payments, only: %i[create destroy index show]
    resources :student_plans, only: %i[create update] do
      get 'student/:student_id',
          to: 'student_plans#student_plans',
          as: :student_plans,
          on: :collection
    end
  end
end
