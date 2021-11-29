# frozen_string_literal: true

FactoryBot.define do
  factory :exercise do
    name { Faker::Games::Zelda.character }
    muscular_group { create(:muscular_group) }
    status { :active }
  end
end
