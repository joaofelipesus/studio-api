# frozen_string_literal: true

class PaymentsQuery < BaseQuery
  def base_relation
    Payment.all
  end

  def call
    joins
    apply_filters
    order
    paginate
    {
      payments: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end

  private

  attr_reader :params

  def apply_filters
    filter_by_student_plan
    filter_by_personal
  end

  def filter_by_student_plan
    return if params[:student_plan_id].blank?

    @relation = @relation.where(student_plan_id: params[:student_plan_id])
  end
end
