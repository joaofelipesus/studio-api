# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :student_plan

  validates :payment_method, :date, :amount, presence: true

  enum payment_method: {
    pix: 'PIX',
    credit: 'CREDIT',
    debit: 'DEBIT',
    money: 'MONEY'
  }
end
