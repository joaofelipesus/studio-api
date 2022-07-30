# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkoutPlan, type: :model do
  subject { create(:workout_plan) }

  it { should belong_to(:personal) }
  it { should have_many(:exercises_groups) }

  it { is_expected.to have_many(:exercise_workout_plans) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }

  it { should validate_uniqueness_of(:name) }

  it do
    should define_enum_for(:status).with_values(
      active: 'ACTIVE',
      inactive: 'INACTIVE'
    ).backed_by_column_of_type(:string)
  end
end
