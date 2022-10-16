# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::CreateService do
  describe '#call' do
    let(:personal) { create(:personal) }

    context 'when student plan isn\'t settled' do
      it 'creates an payment but don\'t update student_plan payment status' do
        plan = create(:plan, duration_in_months: 6, monthly_price: 200, personal:)
        student_plan = create(:student_plan, plan:)
        params = {
          student_plan_id: student_plan.id,
          amount: 500,
          payment_method: :pix,
          date: Date.current,
          personal_id: personal.id
        }

        expect do
          described_class.call(params)
        end.to change(Payment, :count).by(1)

        expect(student_plan.reload.payment_status).to match('pending')
      end
    end

    context 'when plan becomes settled' do
      it 'creates an payment and update student_plan payment status to paid' do
        plan = create(:plan, duration_in_months: 1, monthly_price: 200)
        student_plan = create(:student_plan, plan:)
        params = {
          student_plan_id: student_plan.id,
          amount: 200,
          payment_method: :pix,
          date: Date.current,
          personal_id: personal.id
        }

        expect do
          described_class.call(params)
        end.to change(Payment, :count).by(1)

        expect(student_plan.reload.payment_status).to match('paid')
      end
    end

    context 'when params has errors' do
      let(:error_message) { 'A validação falhou: Valor não pode ficar em branco' }

      it 'returns an invalid payment object with error message' do
        plan = create(:plan, duration_in_months: 1, monthly_price: 200)
        student_plan = create(:student_plan, plan:)
        params = {
          student_plan_id: student_plan.id,
          amount: nil,
          payment_method: :pix,
          date: Date.current,
          personal_id: personal.id
        }

        expect do
          payment = described_class.call(params)

          expect(payment.errors.full_messages).to match([error_message])
        end.not_to change(Payment, :count)
      end
    end
  end
end
