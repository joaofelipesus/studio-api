# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::RevokeAccessService do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:, has_access: true) }

    it 'returns an student' do
      expect(described_class.call(student_id: student.id, personal:)).to be_a(Student)
    end

    it 'change student has_access attribute to false' do
      described_class.call(student_id: student.id, personal:)
      expect(student.reload.has_access).to be_falsey
    end

    it 'don\t update student status when personal isn\'t related to student' do
      wrong_personal = create(:personal)
      described_class.call(student_id: student.id, personal: wrong_personal)
      expect(student.reload.has_access).to be_truthy
    end
  end
end
