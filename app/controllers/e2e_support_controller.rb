# frozen_string_literal: true

class E2eSupportController < ApplicationController
  # This method is used to setup e2e specs.
  def setup
    Rails.logger.debug '############  e2e setup data  ############'
    setup_personal
    setup_create_exercise if params[:new_exercise].present?
    setup_update_exercise if params[:update_exercise].present?
    setup_create_student if params[:create_student].present?
    setup_update_student if params[:update_student].present?
    setup_create_workout_plan if params[:create_workout_plan].present?
    setup_update_workout_plan if params[:update_workout_plan].present?
    Rails.logger.debug '##########################################'
    render json: {}, status: :ok
  end

  private

  def setup_personal
    return if User.find_by(email: 'personal@e2e.com')

    user = User.create(
      email: 'personal@e2e.com',
      password: '123123123',
      kind: :personal,
      status: :confirmed,
      name: 'Personal e2e'
    )
    Personal.create(user: user)
    Rails.logger.debug '=> create personal'
  end

  def setup_create_exercise
    Rails.logger.debug '=> CREATE exercise'
    Exercise.find_by(name: 'Supino e2e')&.destroy
  end

  def setup_update_exercise
    Rails.logger.debug '=> UPDATE exercise'
    Exercise.find_by(id: 'f518aca0-61b9-11ec-90d6-0242ac120003')&.destroy
    Exercise.create(
      id: 'f518aca0-61b9-11ec-90d6-0242ac120003',
      name: '0 Some cool name',
      muscular_group: MuscularGroup.first
    )
  end

  def setup_create_student
    Rails.logger.debug '=> CREATE student'
    user = User.find_by(email: 'create.student@e2e.com')
    if user
      Student.find_by(user: user).destroy
      user.delete
    end
  end

  def setup_update_student
    Rails.logger.debug '=> UPDATE student'
    Rails.logger.debug 'MALAKOI DO HEBRAICO'
    Student.find_by(id: '55797f6a-6265-11ec-90d6-0242ac120003')&.destroy
    User.find_by(id: '3a1b25b0-62ca-11ec-90d6-0242ac120003')&.destroy
    e2e_user = User.find_by(email: 'personal@e2e.com')
    personal = Personal.find_by(user: e2e_user)
    user = User.create!(
      id: '3a1b25b0-62ca-11ec-90d6-0242ac120003',
      email: 'student@email.e2e',
      name: '000 Student',
      password: '123123123',
      kind: :student
    )
    Student.create!(id: '55797f6a-6265-11ec-90d6-0242ac120003', user: user, personal: personal)
  end

  def setup_create_workout_plan
    Rails.logger.debug '=> CREATE workout-plan'
    WorkoutPlan.find_by(name: 'Workout routine e2e')&.destroy
  end

  def setup_update_workout_plan
    Rails.logger.debug '=> UPDATE workout-plan'
    WorkoutPlan.find('5b4c3a64-62c8-11ec-90d6-0242ac120003')&.destroy
    e2e_user = User.find_by(email: 'personal@e2e.com')
    personal = Personal.find_by(user: e2e_user)
    WorkoutPlan.create(
      id: '5b4c3a64-62c8-11ec-90d6-0242ac120003',
      name: '000 Workout routine update e2e',
      personal_id: personal.id
    )
  end
end
