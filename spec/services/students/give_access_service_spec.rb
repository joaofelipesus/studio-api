# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Students::GiveAccessService do
  describe '#call' do
    let(:personal) { create(:personal) }
    let(:student) { create(:student, personal:) }

    it 'updates student user_id and has_access' do
      described_class.call(student_id: student.id, email: 'asuka@nerv.com')
      expect(student.reload.user.nil?).to be_falsey
      expect(student.reload.has_access).to be_truthy
    end

    context 'when student don\'t have an user' do
      let(:student) { create(:student, personal:, has_access: false) }

      it 'don\'t create a new user related to student' do
        user = create(:user)
        student.user = user
        student.save
        expect do
          described_class.call(student_id: student.id, email: 'asuka@nerv.com')
        end.not_to change(User.student, :count)
      end
    end

    context 'when student already have an user' do
      it 'create an new user related to student' do
        described_class.call(student_id: student.id, email: 'asuka@nerv.com')
        expect(User.student.count).to match(1)
      end
    end
  end
end
