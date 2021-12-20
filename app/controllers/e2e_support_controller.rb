# frozen_string_literal: true

class E2eSupportController < ApplicationController
  # This method is used to setup e2e specs.
  def setup
    puts '############  e2e setup data  ############'
    setup_personal
    setup_create_exercise if params[:new_exercise].present?
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
    Exercise.find_by(name: 'Supino e2e').destroy
  end

  def setup_show_exercise
    puts '=> SHOW exercise'
    # Exercise.create(id: ,)
  end
end
