# frozen_string_literal: true

require 'rails_helper'

describe Plan, type: :model do
  subject(:plan) { create(:plan) }

  it { is_expected.to belong_to(:personal) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:duration_in_months) }

  it { should validate_uniqueness_of(:name) }
end
