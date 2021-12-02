# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules, id: :uuid do |t|
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.string :status, default: 'PENDING'
      t.references :personal, null: false, foreign_key: true, type: :uuid
      t.datetime :start_at
      t.references :workout_plan, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
