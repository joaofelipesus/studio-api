# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :email, :kind, :status, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 20 }

  enum kind: {
    personal: 'PERSONAL',
    student: 'STUDENT'
  }

  enum status: {
    confirmed: 'CONFIRMED',
    pending: 'PENDING'
  }
end
