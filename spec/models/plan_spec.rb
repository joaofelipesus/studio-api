# frozen_string_literal: true

require 'rails_helper'

describe Plan, type: :model do
  subject(:plan) { create(:plan) }

  it { is_expected.to belong_to(:personal) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:monthly_price) }
  it { should validate_presence_of(:duration_in_months) }

  it { should validate_uniqueness_of(:name) }

  describe '.total_amount' do
    it 'returns monthly_price multiplied by duration_in_months' do
      plan = build(:plan, duration_in_months: 6, monthly_price: 200)
      expect(plan.total_amount).to match(6 * 200)
    end
  end
end
