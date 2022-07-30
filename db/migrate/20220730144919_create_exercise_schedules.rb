class CreateExerciseSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_schedules, id: :uuid do |t|
      t.integer :exercise_sequence
      t.string :repetitions
      t.string :rest
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.references :exercises_group, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
