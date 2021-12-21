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
    user = User.create(email: 'student@email.e2e', name: 'Student e2e', kind: :student)
    Student.create(id: '55797f6a-6265-11ec-90d6-0242ac120003', user: user)
  end
end
