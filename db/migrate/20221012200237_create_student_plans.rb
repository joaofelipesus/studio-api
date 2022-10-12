class CreateStudentPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :student_plans, id: :uuid do |t|
      t.timestamps

      t.references :plan, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.date :started_at
      t.date :finished_at
      t.string :status
    end
  end
end
