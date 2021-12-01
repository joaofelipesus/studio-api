# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :personal
  belongs_to :user
end
