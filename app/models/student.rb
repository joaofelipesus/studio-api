# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :personal
  belongs_to :objective

  validates :name, uniqueness: true
  validates :name, presence: true

  paginates_per 10
end
