# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'MyString' }
    password_digest { 'MyString' }
    status { 'MyString' }
    name { 'MyString' }
  end
end
