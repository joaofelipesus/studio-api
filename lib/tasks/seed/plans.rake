# frozen_string_literal: true

namespace :seed do
  desc 'Create default plans'
  task :plans, [:personal_id] => :environment do |task, args|
    puts 'Plan [start]'
    return unless Rails.env.development?

    plan = Plan.find_by(personal_id: args[:personal_id], name: 'Anual')
    if plan.nil?
      puts 'Plan [create]'
      Plan.create!(
        [
          {
            name: 'Mensal',
            personal_id: args[:personal_id],
            monthly_price: 350,
            duration_in_months: 1
          },
          {
            name: 'Semestral',
            personal_id: args[:personal_id],
            monthly_price: 3250,
            duration_in_months: 6
          },
          {
            name: 'Anual',
            personal_id: args[:personal_id],
            monthly_price: 300,
            duration_in_months: 12
          }
        ]
      )
    else
      puts 'Plan [skip]'
    end

    puts '-------------------'
  end
end
