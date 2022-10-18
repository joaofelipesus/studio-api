# frozen_string_literal: true

module Personals
class MuscularGroupsController < ApplicationController
  include Secure

  def index
    muscular_groups = MuscularGroup.all.order(name: :asc)
    render_all({ muscular_groups: })
  end
end
end
