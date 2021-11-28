# frozen_string_literal: true

FactoryBot.define do
  factory :exercise do
    name { 'Supino' }
    muscular_group { create(:muscular_group) }
    status { :active }
  end
end
