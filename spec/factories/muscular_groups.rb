# frozen_string_literal: true

FactoryBot.define do
  factory :muscular_group do
    name { Faker::Games::Pokemon.unique.name }
  end
end
