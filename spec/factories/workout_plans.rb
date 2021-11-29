# frozen_string_literal: true

FactoryBot.define do
  factory :workout_plan do
    personal { nil }
    name { 'MyString' }
    status { 'MyString' }
  end
end
