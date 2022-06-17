# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentBuilder do
  describe '#build' do
    subject do
      described_class.new({ user_attributes: { email: 'some@email.com', name: 'some name' } })
    end

    it { expect(subject.build).to be_a Student }
    it { expect(subject.build.user.student?).to be_truthy }
    it { expect(subject.build.user.password.size).to match(8) }
  end
end
