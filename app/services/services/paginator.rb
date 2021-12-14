# frozen_string_literal: true

module Services
  class Paginator
    # @param class_name [String] model class name.
    # @param page [Integer] current page.
    # @param order_by [Hash] attribute used to order registers.
    def initialize(data:, response_key:, page: nil, order_by: nil)
      @data = data
      @response_key = response_key
      @page = page
      @order_by = order_by
      @page ||= 1
      @order_by ||= { created_at: :desc }
    end

    # Return paginated list of objects.
    # @return [Hash] containing object list and pagination metadata.
    def call
      {
        response_key => paginated_data,
        current_page: page,
        total_pages: total_pages
      }
    end

    private

    attr_reader :data, :response_key, :page, :order_by

    ELEMENTS_PER_PAGE = 10

    def paginated_data
      @paginated_data ||= data
                          .order(order_by)
                          .page(page)
                          .per(ELEMENTS_PER_PAGE)
    end

    def total_pages
      paginated_data.total_pages
    end
  end
end
