# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentPlan, type: :model do
  it { should belong_to(:student) }
  it { should belong_to(:plan) }

  it { should validate_presence_of(:started_at) }

  it do
    should define_enum_for(:status).with_values(
      progress: 'progress',
      finished: 'finished',
      canceled: 'canceled'
    ).backed_by_column_of_type(:string)
  end
end
