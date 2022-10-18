# frozen_string_literal: true

module Students
  class ApplicationController < ::ApplicationController
    include StudentSecure

    def current_student
      Student.find_by(user: current_user)
    end
  end
end
