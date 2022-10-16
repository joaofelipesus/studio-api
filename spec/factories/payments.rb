# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    payment_method { :pix }
    amount { 100 }
    date { '2022-10-14' }
    student_plan
    personal
  end
end
