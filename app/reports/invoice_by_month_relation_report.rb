# frozen_string_literal: true

class InvoiceByMonthRelationReport < BaseRelationReport
  private

  def report_data
    @report_data ||= Payment
                     .where(personal:)
                     .where('date >= ?', initial_date)
                     .where('date <= ?', final_date)
                     .group_by_month(:date)
                     .sum(:amount)
  end
end
