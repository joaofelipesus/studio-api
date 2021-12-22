# frozen_string_literal: true

FactoryBot.define do
  factory :workout_plan do
    personal { create(:personal) }
    name { Faker::Games::Zelda.unique.character }
    status { :active }
  end
end
