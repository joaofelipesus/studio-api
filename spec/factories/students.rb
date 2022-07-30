# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    personal { create(:personal) }
    name { Faker::Name.unique.name }

    objective
  end
end
