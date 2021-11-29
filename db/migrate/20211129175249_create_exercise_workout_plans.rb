# frozen_string_literal: true

class CreateExerciseWorkoutPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_workout_plans, id: :uuid do |t|
      t.references :workout_plan, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.string :repetitions
      t.string :rest

      t.timestamps
    end
  end
end
