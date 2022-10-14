# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to(:student_plan) }

  it { is_expected.to validate_presence_of(:payment_method) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:amount) }
end
