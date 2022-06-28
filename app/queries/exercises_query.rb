# frozen_string_literal: true

class ExercisesQuery < BaseQuery
  def base_relation
    Exercise.all
  end

  # rubocop:disable Metrics/MethodLength
  def call
    joins
    apply_filters
    order
    paginate
    {
      exercises: @relation,
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
    @relation = @relation.joins(:muscular_group)
  end

  def apply_filters
    filter_by_name
    filter_by_personal
  end

  def filter_by_personal
    return if params[:personal_id].blank?

    @relation = @relation.where(personal_id: params[:personal_id])
  end

  def order
    @relation = @relation.order(name: :asc)
  end

  def filter_by_name
    return if params[:name].blank?

    @relation = @relation.where('exercises.name ILIKE ?', "%#{params[:name]}%")
  end
end
