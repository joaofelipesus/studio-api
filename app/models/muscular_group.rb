# frozen_string_literal: true

class MuscularGroup < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
