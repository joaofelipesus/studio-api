# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :personal
  belongs_to :objective

  has_many :student_plans, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, presence: true

  paginates_per 10

  def active_plan?
    StudentPlans::FindAndCheckStatusService.call(self)
  end
end
