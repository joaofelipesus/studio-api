# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should belong_to(:personal) }
  it { should belong_to(:user) }

  it { should accept_nested_attributes_for(:user) }
end
