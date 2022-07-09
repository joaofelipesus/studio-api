# frozen_string_literal: true

RSpec.describe Personal, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:exercises) }
end
