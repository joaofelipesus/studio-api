# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    student { nil }
    status { 'MyString' }
    personal { nil }
    start_at { '2021-12-02 21:14:47' }
    workout_plan { nil }
  end
end
