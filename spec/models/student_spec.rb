# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  subject(:student) { build(:student) }

  it { should belong_to(:personal) }
  it { is_expected.to belong_to(:objective) }

  it { is_expected.to have_many(:student_plans) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name) }

  describe '.active_plan?' do
    context 'when student don\'t have any plan' do
      it 'returns false' do
        student = create(:student)
        expect(student.active_plan?).to be_falsey
      end
    end

    context 'when student has plans' do
      it 'returns true if one of them has status progress' do
        student = create(:student)
        create(:student_plan, student:, status: :progress, finished_at: 3.days.from_now.to_date)
        expect(student.active_plan?).to be_truthy
      end

      it 'returns false if none of them has status progress' do
        student = create(:student)
        create(:student_plan, student:, status: :canceled)
        expect(student.active_plan?).to be_falsey
      end
    end
  end
end
