# frozen_string_literal: true

module Students
  class SchedulesController < ApplicationController
    def index
      paginated_schedules = SchedulesQuery.call(
        params: {
          page: params[:page],
          date: params[:date],
          status: params[:status],
          student_id: current_student.id
        }
      )

      render(
        'students/schedules/index',
        formats: :json,
        locals: { paginated_data: paginated_schedules }
      )
    end
  end
end
