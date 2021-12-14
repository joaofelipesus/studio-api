# frozen_string_literal: true

module Services
  module Pagination
    class SearchByName
      # @param klass [Class] model which will be searched.
      # @param name_pattern [String] pattern which will be matched with records.
      def initialize(klass:, name_pattern:)
        @klass = klass
        @name_pattern = name_pattern
      end

      # Returns a list with elements searched by name_pattern.
      def call
        klass.where('name ILIKE ?', "%#{name_pattern}%")
      end

      private

      attr_reader :klass, :name_pattern
    end
  end
end
