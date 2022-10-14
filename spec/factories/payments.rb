# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    student_plan { nil }
    payment_method { 'MyString' }
    date { '2022-10-14' }
  end
end
