# frozen_string_literal: true

module Payments
  class RemoveService
    def initialize(payment_id)
      @payment_id = payment_id
    end

    def self.call(payment_id)
      new(payment_id).call
    end

    def call
      student_plan.update(payment_status: :pending) if pending_value?
      payment.destroy
    end

    private

    attr_reader :payment_id

    def student_plan
      @student_plan ||= payment.student_plan
    end

    def payment
      @payment ||= Payment.find(payment_id)
    end

    def plan
      student_plan.plan
    end

    def pending_value?
      paid_amount = student_plan.payments.pluck(:amount).sum - payment.amount

      plan.total_amount > paid_amount
    end
  end
end
