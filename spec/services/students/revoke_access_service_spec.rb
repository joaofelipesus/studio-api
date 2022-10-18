# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::RevokeAccessService do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:, has_access: true) }

    it 'change student has_access attribute to false' do
      described_class.call(student_id: student.id)
      expect(student.reload.has_access).to be_falsey
    end
  end
end
