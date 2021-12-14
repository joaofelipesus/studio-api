# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :authenticate

  def index
    schedules = Schedule
                .where(personal_id: current_personal.id)
                .order(start_at: :desc)
                .page(params[:page])
    render_all({ schedules: schedules })
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
      :status
    ).merge(personal_id: current_personal.id)
  end
end
