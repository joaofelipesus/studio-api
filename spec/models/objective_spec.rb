# frozen_string_literal: true

RSpec.describe Objective, type: :model do
  it { is_expected.to have_many(:students) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
