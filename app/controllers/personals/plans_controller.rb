# frozen_string_literal: true

module Personals
  class PlansController < ApplicationController
    before_action :set_plan, only: %i[show update]

    def index
      render('personals/plans/index', formats: :json, locals: { paginated_data: plans })
    end

    def show
      render_success(@plan)
    end

    def create
      plan = Plan.new(plan_params)
      if plan.save
        render_success(plan, status: :created)
      else
        render_error_messages(plan)
      end
    end

    def update
      if @plan.update(plan_params)
        render_success(@plan)
      else
        render_error_messages(@plan)
      end
    end

    private

    def plan_params
      params.permit(
        :name,
        :monthly_price,
        :duration_in_months
      ).merge(personal_id: current_personal.id)
    end

    def plans
      PlansQuery.call(
        params: {
          page: params[:page],
          personal_id: current_personal.id,
          all: params[:all]
        }
      )
    end

    def set_plan
      @plan = Plan.find_by!(id: params[:id], personal_id: current_personal.id)
    end
  end
end
