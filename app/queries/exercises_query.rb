# frozen_string_literal: true

class ExercisesQuery < BaseQuery
  def base_relation
    Exercise.all
  end

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

  private

  attr_reader :params

  def joins
    @relation = @relation.joins(:muscular_group)
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

    @relation = @relation.where('exercises.name ILIKE ?', "%#{params[:name]}%")
  end
end
