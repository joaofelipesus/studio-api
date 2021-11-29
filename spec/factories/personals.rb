# frozen_string_literal: true

FactoryBot.define do
  factory :personal do
    user { create(:user, :personal) }
  end
end
