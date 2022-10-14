# frozen_string_literal: true

module Payments
  class RemoveService
    def initialize(params)
      @params = params
    end

    def self.call(params)
      new(params).call
    end

    def call
      student_plan.update(payment_status: :pending) if pending_value?
      payment.destroy
    end

    private

    attr_reader :params

    def student_plan
      @student_plan ||= payment.student_plan
    end

    def payment
      @payment ||= Payment.find(params[:id])
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
