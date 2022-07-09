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
    return if dont_paginate?

    @relation = @relation.page(current_page).per(ELEMENTS_PER_PAGE)
  end

  def total_pages
    return 1 if dont_paginate?

    @relation.total_pages
  end

  def current_page
    return 1 if params[:page].blank? ||dont_paginate?

    params[:page]
  end

  def dont_paginate?
    params[:all] == 'true'
  end
end
