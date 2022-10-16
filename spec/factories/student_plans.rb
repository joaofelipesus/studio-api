# frozen_string_literal: true

FactoryBot.define do
  factory :student_plan do
    started_at { '2022-10-12' }
    finished_at { '2022-10-12' }
    status { :progress }
    payment_status { :pending }
    student
    plan
  end
end
