# frozen_string_literal: true

class MuscularGroupsController < ApplicationController
  include Secure

  def index
    muscular_groups = MuscularGroup.all.order(name: :asc)
    render_all({ muscular_groups: })
  end
end
