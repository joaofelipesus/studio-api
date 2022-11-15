# frozen_string_literal: true

module Personals
  class ApplicationController < ::ApplicationController
    include PersonalSecure

    def current_personal
      Personal.find_by(user: current_user)
    end
  end
end
