# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    scope :personal, module: 'personals' do
      resources :exercises, only: %i[create update show index destroy]
      resources :exercise_workout_plans, only: %i[create update show index]
      resources :exercises_groups, only: %i[create destroy show]
      resources :muscular_groups, only: %i[index]
      resources :objectives, only: %i[index]
      resources :payments, only: %i[create destroy index show]
      resources :plans, only: %i[create update index show]
      resources :schedules, only: %i[create update show index destroy]
      resources :student_plans, only: %i[create update show] do
        get 'student/:student_id',
            to: 'student_plans#student_plans',
            as: :student_plans,
            on: :collection
      end
      resources :students, only: %i[create update show index destroy] do
        post 'give_access',
             to: 'students#give_access',
             as: :give_student_access,
             on: :collection

        put ':id/revoke_access',
            to: 'students#revoke_access',
            as: :revoke_student_access,
            on: :collection
      end
      resources :workout_plans, only: %i[create update show index]
      resources :reports do
        get :students_count, to: 'reports#students_count', as: :students_count, on: :collection
      end
    end

    scope :student, module: 'students' do
      resources :schedules, only: %i[index]
      resources :student_plans, only: %i[index]
    end

    post '/users/login', to: 'users#login', as: :login
  end
end
