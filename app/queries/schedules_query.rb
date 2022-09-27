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
    filter_by_date
  end

  def filter_by_personal
    return if params[:personal_id].blank?

    @relation = @relation.where(personal_id: params[:personal_id])
  end

  def filter_by_date
    return if params[:date].blank?

    @relation = @relation.where(date: params[:date])
  end

  def order
    @relation = @relation.order(date: :asc)
  end
end
