# frozen_string_literal: true

class Plan < ApplicationRecord
  validates :name, :value, presence: true
  validates :name, uniqueness: true
end
