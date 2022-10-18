# frozen_string_literal: true

module Personals
  class PaymentsController < ApplicationController
    def index
      render('personals/payments/index', formats: :json, locals: { paginated_data: payments })
    end

    def show
      payment = Payment.find_by!(id: params[:id], personal_id: current_personal.id)
      render_success(payment)
    end

    def create
      payment = Payments::CreateService.call(payments_params)
      if payment.id
        render_success(payment, status: :created)
      else
        render_error_messages(payment)
      end
    end

    def destroy
      Payments::RemoveService.call(params[:id])
      render status: :ok, json: {}
    end

    private

    def payments_params
      params.permit(
        :student_plan_id,
        :date,
        :amount,
        :payment_method
      ).merge(personal_id: current_personal.id)
    end

    def payments
      PaymentsQuery.call(
        params: {
          page: params[:page],
          personal_id: current_personal.id,
          student_plan_id: params[:student_plan_id],
          all: params[:all]
        }
      )
    end
  end
end
