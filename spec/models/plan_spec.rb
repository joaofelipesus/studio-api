# frozen_string_literal: true

require 'rails_helper'

describe Plan, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }

  it { should validate_uniqueness_of(:name) }
end
