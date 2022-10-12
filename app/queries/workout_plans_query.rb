# frozen_string_literal: true

class WorkoutPlansQuery < BaseQuery
  def base_relation
    WorkoutPlan.all
  end

  # rubocop:disable Metrics/MethodLength
  def call
    joins
    apply_filters
    order
    paginate
    {
      workout_plans: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end
  # rubocop:enable Metrics/MethodLength

  private

  attr_reader :params

  def joins
    @relation = @relation.includes(:exercise_workout_plans)
  end

  def apply_filters
    filter_by_name
    filter_by_personal
  end

  def order
    @relation = @relation.order(name: :asc)
  end

  def filter_by_name
    return if params[:name].blank?

    @relation = @relation.where('workout_plans.name ILIKE ?', "%#{params[:name]}%")
  end
end
