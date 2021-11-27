# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'MyString' }
    password_digest { 'MyString' }
    status { 'MyString' }
    name { 'MyString' }
    confirmation_token { 'MyString' }
    last_login { '2021-11-27 18:30:13' }
  end
end
