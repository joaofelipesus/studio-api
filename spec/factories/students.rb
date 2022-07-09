# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    personal { create(:personal) }

    objective
  end
end
