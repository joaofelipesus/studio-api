# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    student { create(:student) }
    status { :pending }
    personal { create(:personal) }
    start_at { 2.days.ago }
    workout_plan { create(:workout_plan) }
    date { Date.current }
  end
end
