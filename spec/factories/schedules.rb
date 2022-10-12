# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    student { create(:student, name: 'Asuka') }
    status { :pending }
    personal { create(:personal) }
    start_at { '18:30' }
    workout_plan { create(:workout_plan) }
    date { Date.current }
  end
end
