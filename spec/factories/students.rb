# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    personal { create(:personal) }
    user { create(:user, :student) }
  end
end
