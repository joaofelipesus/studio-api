# frozen_string_literal: true

module Payments
  class CreateService
    def initialize(params)
      @params = params
      @payment = Payment.new
    end

    def self.call(params)
      new(params).call
    end

    def call
      @payment = Payment.create!(params)
      student_plan.update(payment_status: :paid) if plan_settled?
      @payment
    rescue ActiveRecord::RecordInvalid => exception
      @payment.errors.add(:base, message: exception.message)
      @payment
    end

    private

    attr_reader :params

    def student_plan
      @student_plan ||= StudentPlan.find(params[:student_plan_id])
    end

    def plan
      student_plan.plan
    end

    def plan_settled?
      paid_amount = student_plan.payments.pluck(:amount).sum

      paid_amount >= plan.total_amount
    end
  end
end
