# frozen_string_literal: true

class User < ApplicationRecord
  has_one :student

  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :email, :kind, :status, :name, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 20 }, on: :create

  enum kind: {
    personal: 'PERSONAL',
    student: 'STUDENT'
  }

  enum status: {
    confirmed: 'CONFIRMED',
    pending: 'PENDING'
  }
end
