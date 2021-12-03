# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { should belong_to(:student) }
  it { should belong_to(:workout_plan) }
  it { should belong_to(:personal) }

  it { should validate_presence_of(:start_at) }

  it do
    should define_enum_for(:status).with_values(
      pending: 'PENDING',
      progress: 'PROGRESS',
      done: 'DONE',
      canceled: 'CANCELED'
    ).backed_by_column_of_type(:string)
  end
end
