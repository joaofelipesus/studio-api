# frozen_string_literal: true

class PlansQuery < BaseQuery
  def base_relation
    Plan.all
  end

  def call
    joins
    apply_filters
    order
    paginate
    {
      plans: @relation,
      meta: {
        total_pages:,
        current_page:
      }
    }
  end

  private

  attr_reader :params

  def apply_filters
    filter_by_personal
  end

  def order
    @relation = @relation.order(name: :asc)
  end
end
