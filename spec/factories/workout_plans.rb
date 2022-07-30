# frozen_string_literal: true

FactoryBot.define do
  factory :workout_plan do
    personal { create(:personal) }
    name { Faker::Address.unique.country }
    status { :active }
  end
end
