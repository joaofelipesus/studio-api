# frozen_string_literal: true

class BaseRelationReport
  def initialize(year:, personal:)
    @year = year
    @personal = personal
  end

  def self.call(personal:, year: Date.current.year)
    new(year:, personal:).call
  end

  def call
    report = {}
    report_dates.each do |date|
      formatted_date = "#{date.month}/#{date.year}"
      report[formatted_date] = report_data[date]
    end

    report
  end

  private

  attr_reader :year, :personal

  # NOTE: this nmethod must be overrided
  def report_data; end

  def report_dates
    report_data.keys
  end

  def initial_date
    return year.beginning_of_year if year.is_a?(Date)

    "#{year}-01-01".to_date
  end

  def final_date
    return year.end_of_year if year.is_a?(Date)

    "#{year}-12-31".to_date
  end
end
