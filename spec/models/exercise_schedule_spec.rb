# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExerciseSchedule, type: :model do
  subject do
    create(:exercise_schedule,
           exercises_group: create(:exercises_group,
                                   workout_plan: create(:workout_plan, name: 'Yolo')))
  end

  it { should belong_to(:exercises_group) }
  it { should belong_to(:exercise) }

  it { should validate_presence_of(:rest) }
  it { should validate_presence_of(:repetitions) }
  it { should validate_presence_of(:exercise_sequence) }

  it { should validate_uniqueness_of(:exercise_sequence).scoped_to(:exercises_group_id) }

  it { should validate_length_of(:exercise_sequence).is_at_least(1) }

  it do
    should define_enum_for(:rest).with_values(
      free: 'FREE',
      thirthy_seconds: 'THIRTHY_SECONDS',
      one_minute: 'ONE_MINUTE'
    ).backed_by_column_of_type(:string)
  end

  it do
    should define_enum_for(:repetitions).with_values(
      between_eight_and_twelve: 'BETWEEN_EIGHT_AND_TWELVE',
      six: 'SIX',
      pyramid: 'PYRAMID',
      drop_set: 'DROP_SET'
    ).backed_by_column_of_type(:string)
  end
end
