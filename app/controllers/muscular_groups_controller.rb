# frozen_string_literal: true

class MuscularGroupsController < ApplicationController
  before_action :authenticate

  def index
    muscular_groups = MuscularGroup.all.order(name: :asc)
    render_all({ muscular_groups: })
  end
end
