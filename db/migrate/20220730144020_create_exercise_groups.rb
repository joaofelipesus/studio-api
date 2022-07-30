class CreateExerciseGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_groups, id: :uuid do |t|
      t.references :workout_plan, null: false, foreign_key: true, type: :uuid
      t.integer :execution_sequence

      t.timestamps
    end
  end
end
