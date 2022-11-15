# frozen_string_literal: true

module Personals
  class ReportsController < ApplicationController
    def students_count
      render json: { students_count: Student.where(personal: current_personal).count }, status: :ok
    end
  end
end
