# frozen_string_literal: true

namespace :seed do
  desc 'Create default student_plans'
  task :student_plans, [:personal_id] => :environment do |task, args|
    puts 'Student plans [start]'
    return unless Rails.env.development?

    student_plan_count = StudentPlan.count
    if student_plan_count < 15
      puts 'Student plans [create]'
      students_without_plan(args[:personal_id]).each do |student|
        StudentPlan.create!(
          plan: Plan.where(personal_id: args[:personal_id]).sample,
          student:,
          started_at: 3.months.ago.to_date,
          status: :progress,
          payment_status: :pending
        )
      end
    else
      puts 'Student plans [skip]'
    end

    puts '-------------------'
  end

  def students_without_plan(personal_id)
    Student.where(personal_id:).take(15)
  end
end
