# frozen_string_literal: true

namespace :seed do
  desc 'Create default exercises'
  task complete: :environment do |task, args|
    Rake::Task['db:seed'].invoke
    Rake::Task['seed:personal'].invoke
    puts 'Exercises [start]'
    Rake::Task['default_registers:exercises'].invoke(personal.id)
    puts 'Exercises [create]'
    puts '-------------------'
    Rake::Task['seed:plans'].invoke(personal.id)
    Rake::Task['seed:students'].invoke(personal.id)
    Rake::Task['seed:workout_plans'].invoke(personal.id)
  end

  def personal
    personal_user = User.find_by(email: 'joao.sus@email.com')
    Personal.find_by(user: personal_user)
  end
end
