# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { 'Some plan name' }
    value { 300.0 }
    duration_in_months { 6 }

    personal
  end
end
