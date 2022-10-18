# frozen_string_literal: true

module Students
  class StudentPlansController < ApplicationController
    def index
      render('students/student_plans/index', formats: :json, locals: { paginated_data: plans })
    end

    private

    def plans
      StudentPlansQuery.call(
        params: {
          student_id: current_student.id,
          all: params[:all]
        }
      )
    end
  end
end
