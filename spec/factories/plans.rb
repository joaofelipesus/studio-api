# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { Faker::Name.name }
    monthly_price { 300.0 }
    duration_in_months { 6 }

    personal
  end
end
