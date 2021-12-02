# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :authenticate

  def index
    students = Student.joins(:user).all.order(:name)
    render_all(students)
  end

  def show
    student = Student.find(params[:id])
    render_success(student)
  end

  def create
    student = StudentBuilder.new(student_params).build
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
      user_attributes: %i[email name]
    ).merge(personal_id: current_personal.id)
  end
end
