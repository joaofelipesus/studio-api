# frozen_string_literal: true

class CreateWorkoutPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_plans, id: :uuid do |t|
      t.references :personal, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :status, default: 'ACTIVE'

      t.timestamps
    end
  end
end
