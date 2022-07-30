# frozen_string_literal: true

class ExerciseSchedule < ApplicationRecord
  belongs_to :exercise
  belongs_to :exercises_group

  validates :exercise_sequence, :rest, :repetitions, presence: true
  validates :exercise_sequence, uniqueness: { scope: %i[exercises_group_id] }
  validates :exercise_sequence, length: { minimum: 1 }

  enum rest: {
    free: 'FREE',
    thirty_seconds: 'THIRTHY_SECONDS',
    one_minute: 'ONE_MINUTE'
  }

  enum repetitions: {
    between_eight_and_twelve: 'BETWEEN_EIGHT_AND_TWELVE',
    six: 'SIX',
    pyramid: 'PYRAMID',
    drop_set: 'DROP_SET'
  }
end
