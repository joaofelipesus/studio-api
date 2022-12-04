# frozen_string_literal: true

namespace :seed do
  desc 'Create default exercises'
  task personal: :environment do |task, args|
    puts 'Personal [start]'
    return unless Rails.env.development?

    email = 'joao.sus@email.com'
    personal_user = User.find_by(email:)
    if personal_user.nil?
      puts 'Personal [create]'
      user = User.create!(
        email:,
        password: '123123123',
        kind: :personal,
        confirmed_at: Time.now,
        name: 'João Felipe',
        status: :confirmed
      )
      Personal.create!(user:)
    else
      puts 'Personal [skip]'
    end

    puts '-------------------'
  end
end
