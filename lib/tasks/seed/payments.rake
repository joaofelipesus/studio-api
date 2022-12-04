# frozen_string_literal: true

namespace :seed do
  desc 'Create default payment'
  task :payments, [:personal_id] => :environment do |task, args|
    puts 'Payment [start]'
    return unless Rails.env.development?

    payments_count = Payment.where(personal_id: args[:personal_id]).count
    if payments_count < 10
      puts 'Payment [create]'
      StudentPlan.take(15).each do |student_plan|
        plan = student_plan.plan
        value = 0
        value = plan.total_amount / 4 if plan.name == 'Anual'
        value = plan.total_amount / 2 if plan.name == 'Semestral'
        value = plan.total_amount if plan.name == 'Mensal'

        Payment.create!(
          student_plan:,
          amount: value,
          date: rand(0..3).months.ago,
          personal_id: args[:personal_id],
          payment_method: Payment.payment_methods.keys.sample
        )

        student_plan.update(payment_status: :paid) if student_plan.pending_value == 0
      end
    else
      puts 'Payment [skip]'
    end

    puts '-------------------'
  end
end
