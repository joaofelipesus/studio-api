# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students, id: :uuid do |t|
      t.references :personal, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
