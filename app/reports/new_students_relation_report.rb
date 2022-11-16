# frozen_string_literal: true

class NewStudentsRelationReport < BaseReport
  private

  def report_data
    @report_data ||= Student
                           .where(personal:)
                           .where('created_at >= ?', initial_date)
                           .where('created_at <= ?', final_date)
                           .group_by_month(:created_at)
                           .count
  end
end
