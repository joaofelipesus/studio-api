# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { '123123123' }
    status { :confirmed }
    name { 'Asuka Langley' }
    confirmation_token { nil }
    last_login { '2021-11-27 18:30:13' }
    kind { :personal }
  end
end
