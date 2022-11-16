# frozen_string_literal: true

class StudentPlan < ApplicationRecord
  belongs_to :plan
  belongs_to :student

  has_many :payments, dependent: :destroy

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

  def pending_value
    plan.total_amount - payments.sum(&:amount)
  end
end
