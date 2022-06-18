# frozen_string_literal: true

class Personal < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy
end
