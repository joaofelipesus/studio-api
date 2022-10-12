# frozen_string_literal: true

class StudentPlan < ApplicationRecord
  belongs_to :plan
  belongs_to :student

  validates :started_at, presence: true

  enum status: {
    progress: 'progress',
    finished: 'finished',
    canceled: 'canceled'
  }
end
