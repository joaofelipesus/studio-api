# frozen_string_literal: true

class StudentsController < ApplicationController
  include Secure
  before_action :set_student, only: %i[show update destroy]

  def index
    render(
      'students/index',
      formats: :json,
      locals: { paginated_data: paginated_students }
    )
  end

  def show
    render_success(@student)
  end

  def create
    student = Student.new(student_params)
    if student.save
      render_success(student, status: :created)
    else
      render_error_messages(student)
    end
  end

  def update
    if @student.update(student_params)
      render_success(@student)
    else
      render_error_messages(@student)
    end
  end

  def destroy
    @student.destroy
    render(json: {}, status: :ok)
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.permit(
      :name,
      :objective_id
    ).merge(personal_id: current_personal.id)
  end

  def paginated_students
    StudentsQuery.call(
      params: {
        page: params[:page],
        personal_id: current_personal.id,
        name: params[:name],
        all: params[:all]
      }
    )
  end
end
