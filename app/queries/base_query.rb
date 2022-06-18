# frozen_string_literal: true

class BaseQuery
  ELEMENTS_PER_PAGE = 10

  def initialize(params:, relation: base_relation)
    @params = params
    @relation = relation
  end

  def self.call(params:)
    new(params:).call
  end

  # Overload methods
  def joins; end
  def apply_filters; end
  def order; end

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
