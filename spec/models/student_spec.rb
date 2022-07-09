# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  subject(:student) { build(:student) }

  it { should belong_to(:personal) }
  it { is_expected.to belong_to(:objective) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name) }
end
