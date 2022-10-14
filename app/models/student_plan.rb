# frozen_string_literal: true

class StudentPlan < ApplicationRecord
  belongs_to :plan
  belongs_to :student

  validates :started_at, :status, presence: true

  enum status: {
    progress: 'progress',
    finished: 'finished',
    canceled: 'canceled'
  }

  enum payment_status: {
    pending: 'PENDING',
    paid: 'PAID'
  }
end
