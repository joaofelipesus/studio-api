# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :personal
  belongs_to :user

  accepts_nested_attributes_for :user, update_only: true
end