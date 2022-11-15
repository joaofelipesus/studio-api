# frozen_string_literal: true

class NewStudentsRelationReport
  def initialize(year:, personal:)
    @year = year
    @personal = personal
  end

  def self.call(personal:, year: Date.current.year)
    new(year:, personal:).call
  end

  def call
    report_data = {}
    report_dates.each do |date|
      formatted_date = "#{date.month}/#{date.year}"
      report_data[formatted_date] = students_relation[date]
    end

    report_data
  end

  private

  attr_reader :year, :personal

  def students_relation
    @students_relation ||= Student
                           .where(personal:)
                           .where('created_at >= ?', initial_date)
                           .where('created_at <= ?', final_date)
                           .group_by_month(:created_at)
                           .count
  end

  def report_dates
    students_relation.keys
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
