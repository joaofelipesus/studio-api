# frozen_string_literal: true

class StudentsController < ApplicationController
  include Secure

  def index
    return render_all_students if params[:all]

    paginated_data = Services::Pagination::Index.new(
      klass: Student,
      params:,
      order_by: { 'users.name' => :asc },
      join_table: :user
    ).call
    render_all(paginated_data)
  end

  def show
    student = Student.find(params[:id])
    render_success(student)
  end

  def create
    student = Student.new(student_params).build
    if student.save
      render_success(student, status: :created)
    else
      render_error_messages(student)
    end
  end

  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      render_success(student)
    else
      render_error_messages(student)
    end
  end

  private

  def student_params
    params.permit(
      :name,
      :objective_id
    ).merge(personal_id: current_personal.id)
  end

  def render_all_students
    students = Student.joins(:user).where(personal: current_personal).order('users.name' => :asc)
    render_all({ students: }, paginate: false)
  end
end
