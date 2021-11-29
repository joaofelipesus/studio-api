# frozen_string_literal: true

class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises, id: :uuid do |t|
      t.string :name
      t.references :muscular_group, null: false, foreign_key: true, type: :uuid
      t.string :status, default: 'ACTIVE'

      t.timestamps
    end
  end
end
