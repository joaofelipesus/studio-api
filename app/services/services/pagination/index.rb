# frozen_string_literal: true

module Services
  module Pagination
    class Index
      # @param klass [ActiveModelClass]
      # @param params [ActionController::Parameters] request params.
      def initialize(klass:, params:, order_by: { name: :asc }, join_table: nil)
        @klass = klass
        @params = params
        @order_by = order_by
        @join_table = join_table
      end

      # Returns list with paginated data.
      def call
        return paginate(raw_registers) unless search_by_name?

        paginate(filtered_data)
      end

      private

      attr_reader :klass, :params, :order_by, :join_table

      def paginate(data)
        Services::Pagination::Paginator.new(
          data: data,
          response_key: elements_key,
          page: params[:page],
          order_by: order_by
        ).call
      end

      def raw_registers
        klass.all unless join_table

        klass.joins(join_table).all
      end

      def search_by_name?
        params[:name].present?
      end

      def filtered_data
        Services::Pagination::SearchByName.new(
          klass: klass,
          name_pattern: params[:name]
        ).call
      end

      def elements_key
        klass
          .name
          .underscore
          .pluralize
          .to_sym
      end
    end
  end
end
