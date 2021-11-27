# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:status) }

  it { should validate_uniqueness_of(:email) }

  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_length_of(:password).is_at_most(20) }

  it do
    should define_enum_for(:kind).with_values(
      personal: 'PERSONAL',
      student: 'STUDENT'
    ).backed_by_column_of_type(:string)
  end

  it do
    should define_enum_for(:status).with_values(
      confirmed: 'CONFIRMED',
      pending: 'PENDING'
    ).backed_by_column_of_type(:string)
  end
end
