# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesGroup, type: :model do
 it { is_expected.to belong_to(:workout_plan) }
 it { is_expected.to have_many(:exercise_schedules) }
end
