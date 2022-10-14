# frozen_string_literal: true

class AddPaymentStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :student_plans, :payment_status, :string, default: 'PENDING', comment: 'column with student_plan payment situation'
  end
end
