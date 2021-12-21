# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { '123123123' }
    status { :confirmed }
    name { Faker::JapaneseMedia::Naruto.character }
    confirmation_token { nil }
    last_login { '2021-11-27 18:30:13' }
    kind { :personal }

    trait :personals do
      kind { :personal }
    end

    trait :students do
      kidn { :student }
    end
  end
end
