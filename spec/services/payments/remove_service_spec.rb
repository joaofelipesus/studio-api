# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::RemoveService do
  describe '#call' do
    let(:personal) { create(:personal) }

    context 'when student plan isn\'t settled' do
      it 'removes an payment but don\'t update student_plan payment status' do
        plan = create(:plan, duration_in_months: 6, monthly_price: 200, personal:)
        student_plan = create(:student_plan, plan:)
        payment = create(:payment, amount: 300, student_plan:)

        expect do
          described_class.call(payment.id)
        end.to change(Payment, :count).by(-1)

        expect(student_plan.reload.payment_status).to match('pending')
      end
    end

    context 'when student plan is settled' do
      it 'removes an payment but don\'t update student_plan payment status' do
        plan = create(:plan, duration_in_months: 6, monthly_price: 200, personal:)
        student_plan = create(:student_plan, plan:, payment_status: :paid)
        create(:payment, amount: 1000, student_plan:)
        payment = create(:payment, amount: 200, student_plan:)

        expect do
          described_class.call(payment.id)
        end.to change(Payment, :count).by(-1)

        expect(student_plan.reload.payment_status).to match('pending')
      end
    end
  end
end
