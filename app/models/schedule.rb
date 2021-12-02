# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :student
  belongs_to :personal
  belongs_to :workout_plan

  validates :start_at, presence: true

  enum status: {
    pending: 'PENDING',
    progress: 'PROGRESS',
    done: 'DONE',
    canceled: 'CANCELED'
  }
end
