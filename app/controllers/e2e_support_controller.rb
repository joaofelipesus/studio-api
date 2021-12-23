# frozen_string_literal: true

class E2eSupportController < ApplicationController
  # This method is used to setup e2e specs.
  def setup
    puts '############  e2e setup data  ############'
    setup_personal
    setup_create_exercise if params[:new_exercise].present?
    setup_update_exercise if params[:update_exercise].present?
    setup_create_student if params[:create_student].present?
    setup_update_student if params[:update_student].present?
    setup_create_workout_plan if params[:create_workout_plan].present?
    setup_update_workout_plan if params[:update_workout_plan].present?
    setup_create_schedule if params[:create_schedule].present?
    setup_update_schedule if params[:update_schedule].present?
    puts '##########################################'
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
    puts '=> create personal'
  end

  def setup_create_exercise
    puts '=> CREATE exercise'
    Exercise.find_by(name: 'Supino e2e')&.destroy
  end

  def setup_update_exercise
    puts '=> UPDATE exercise'
    Exercise.find_by(id: 'f518aca0-61b9-11ec-90d6-0242ac120003')&.destroy
    Exercise.create(
      id: 'f518aca0-61b9-11ec-90d6-0242ac120003',
      name: '0 Some cool name',
      muscular_group: MuscularGroup.first
    )
  end

  def setup_create_student
    puts '=> CREATE student'
    user = User.find_by(email: 'create.student@e2e.com')
    if user
      Student.find_by(user: user).destroy
      user.delete
    end
  end

  def setup_update_student
    puts '=> UPDATE student'
    Schedule.where(personal: personal_e2e)&.delete_all
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
    Student.create(id: '55797f6a-6265-11ec-90d6-0242ac120003', user: user, personal: personal)
  end

  def setup_create_workout_plan
    puts '=> CREATE workout-plan'
    WorkoutPlan.find_by(name: 'Workout routine e2e')&.destroy
  end

  def setup_update_workout_plan
    puts '=> UPDATE workout-plan'
    Schedule.where(personal: personal_e2e)&.delete_all
    WorkoutPlan.find('5b4c3a64-62c8-11ec-90d6-0242ac120003')&.destroy
    e2e_user = User.find_by(email: 'personal@e2e.com')
    personal = Personal.find_by(user: e2e_user)
    WorkoutPlan.create(
      id: '5b4c3a64-62c8-11ec-90d6-0242ac120003',
      name: '000 Workout routine update e2e',
      personal_id: personal.id
    )
  end

  def setup_create_schedule
    puts '=> CREATE schedule'
    Schedule.where(personal: personal_e2e)&.delete_all
    setup_update_student
    setup_update_workout_plan
  end

  def setup_update_schedule
    puts '=> UPDATE schedule'
    Schedule.where(personal: personal_e2e)&.delete_all
    student = setup_update_student
    workout_plan = setup_update_workout_plan
    Schedule.create(
      id: '58a32a7a-ab63-4b9c-86f3-152b6f514b00',
      student: student,
      workout_plan: workout_plan,
      personal: personal_e2e,
      date: Date.current,
      start_at: '15:45'
    )
  end

  def personal_e2e
    e2e_user = User.find_by(email: 'personal@e2e.com')
    Personal.find_by(user: e2e_user)
  end
end
