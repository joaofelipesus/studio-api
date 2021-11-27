# frozen_string_literal: true

class CreatePersonals < ActiveRecord::Migration[6.1]
  def change
    create_table :personals, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
