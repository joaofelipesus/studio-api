# frozen_string_literal: true

class SchedulesQuery < BaseQuery
  def base_relation
    Schedule.all
  end

  # rubocop:disable Metrics/MethodLength
  def call
    joins
    apply_filters
    order
    paginate
    {
      schedules: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end
  # rubocop:enable Metrics/MethodLength

  private

  attr_reader :params

  def apply_filters
    filter_by_personal
    filter_by_student
    filter_by_date
    filter_by_status
  end

  def filter_by_personal
    return if params[:personal_id].blank?

    @relation = @relation.where(personal_id: params[:personal_id])
  end

  def filter_by_date
    return if params[:date].blank?

    @relation = @relation.where(date: params[:date])
  end

  def filter_by_student
    return if params[:student_id].blank?

    @relation = @relation.where(student_id: params[:student_id])
  end

  def filter_by_status
    return if params[:status].blank?

    @relation = @relation.where(status: params[:status])
  end

  def order
    @relation = @relation.order(date: :asc)
  end
end
