# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :personal

  validates :name, :monthly_price, :duration_in_months, presence: true
  validates :name, uniqueness: true
end
