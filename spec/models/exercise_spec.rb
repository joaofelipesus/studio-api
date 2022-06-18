# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject { create(:exercise) }

  it { should belong_to(:muscular_group) }
  it { should belong_to(:personal) }

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
