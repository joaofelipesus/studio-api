# frozen_string_literal: true

class StudentPlansQuery < BaseQuery
  def base_relation
    StudentPlan.all
  end

  def call
    joins
    apply_filters
    order
    paginate
    {
      student_plans: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end

  private

  attr_reader :params

  def apply_filters
    filter_by_student
  end

  def filter_by_student
    return if params[:student_id].blank?

    @relation = @relation.where(student_id: params[:student_id])
  end
end
