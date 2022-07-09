# frozen_string_literal: true

class Objective < ApplicationRecord
  has_many :students

  validates :name, presence: true
  validates :name, uniqueness: true
end
