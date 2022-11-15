# frozen_string_literal: true

module Personals
  class ObjectivesController < ApplicationController
    def index
      objectives = Objective.all.order(name: :asc)
      render_all({ objectives: })
    end
  end
end
