# frozen_string_literal: true

class SchedulesController < ApplicationController
  include Secure

  before_action :set_schedule, only: %i[show update destroy]

  def index
    paginated_schedules = SchedulesQuery.call(
      params: {
        page: params[:page],
        personal_id: current_personal.id
      }
    )

    render('schedules/index', formats: :json, locals: { paginated_data: paginated_schedules })
  end

  def show
    render_success(@schedule)
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
    if @schedule.update(schedule_params)
      render_success(@schedule)
    else
      render_error_messages(@schedule)
    end
  end

  def destroy
    @schedule.destroy
    render(json: {}, status: :ok)
  end

  private

  def set_schedule
    @schedule = Schedule.find_by!(id: params[:id], personal: current_personal)
  end

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
