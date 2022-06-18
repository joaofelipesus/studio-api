# frozen_string_literal: true

class ExercisesQuery
  # def self.base_relation
  #   Exercise.all
  # end

  def initialize(params:)
    @params = params
    @relation = Exercise.all
  end

  def self.call(params:)
    new(params:).call
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
    filter_by_personal
  end

  def filter_by_personal
    return if params[:personal_id].blank?

    @relation = @relation.where(personal_id: params[:personal_id])
  end

  def order
    @relation = @relation.order(name: :asc)
  end

  # TODO: extract pagination.
  ELEMENTS_PER_PAGE = 10

  def paginate
    @relation = @relation.page(current_page).per(ELEMENTS_PER_PAGE)
  end

  def total_pages
    @relation.total_pages
  end

  def current_page
    return 1 if params[:page].blank?

    params[:page]
  end
end
