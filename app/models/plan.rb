# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :personal

  validates :name, :value, presence: true
  validates :name, uniqueness: true
end
