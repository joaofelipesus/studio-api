# frozen_string_literal: true

class SchedulesController < ApplicationController
  include Secure

  # TODO: limit by schedules of current personal.
  def index
    paginated_schedules = Services::Pagination::Index.new(
      klass: Schedule,
      params:,
      order_by: { date: :desc, start_at: :desc }
    ).call
    render_all(paginated_schedules)
  end

  def show
    schedule = Schedule.find(params[:id])
    render_success(schedule)
  end

  def create
    schedule = Schedule.new(schedule_params)
    if schedule.save
      render_success(schedule, status: :created)
    else
      render_error_messages(schedule)
    end
  end

  def update
    schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      render_success(schedule)
    else
      render_error_messages(schedule)
    end
  end

  private

  def schedule_params
    params.permit(
      :student_id,
      :workout_plan_id,
      :start_at,
      :status,
      :date
    ).merge(personal_id: current_personal.id)
  end
end
