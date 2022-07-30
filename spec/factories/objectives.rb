# frozen_string_literal: true

FactoryBot.define do
  factory :objective do
    name { Faker::JapaneseMedia::Naruto.character }
  end
end
