# frozen_string_literal: true

FactoryBot.define do
  factory :objective do
    name { Faker::Games::Zelda.unique.character }
  end
end
