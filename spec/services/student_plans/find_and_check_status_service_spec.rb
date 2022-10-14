# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentPlans::FindAndCheckStatusService do
  describe '#call' do
    let(:plan) { create(:plan) }
    let(:student) { create(:student) }

    context 'when student don\'t have any plans' do
      it 'returns false' do
        expect(described_class.call(student)).to be_falsy
      end
    end

    context 'when student has plans' do
      context 'when all plans are finished or canceled' do
        it 'returns false and don\'t change any finished_at' do
          create(:student_plan, student:, plan:, status: :finished)
          create(:student_plan, student:, plan:, status: :canceled)
          expect(described_class.call(student)).to be_falsy
        end
      end

      context 'when student has progress plans' do
        it 'changes status to finished when current date is bigger than finished at date' do
          student_plan = create(
            :student_plan,
            student:,
            plan:,
            status: :progress,
            finished_at: 6.days.ago.to_date
          )
          expect(described_class.call(student)).to be_falsy
          expect(student_plan.reload.status).to match('finished')
        end

        it 'don\'t change status to finished when current date is smaller than finished at date' do
          student_plan = create(
            :student_plan,
            student:,
            plan:,
            status: :progress,
            finished_at: 6.days.from_now.to_date
          )
          expect(described_class.call(student)).to be_truthy
          expect(student_plan.reload.status).to match('progress')
        end
      end
    end
  end
end
