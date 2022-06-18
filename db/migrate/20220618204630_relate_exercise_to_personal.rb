# frozen_string_literal: true

class RelateExerciseToPersonal < ActiveRecord::Migration[7.0]
  def change
    add_reference :exercises, :personals, type: :uuid, index: true
  end
end
