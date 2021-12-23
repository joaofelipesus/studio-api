# frozen_string_literal: true

class ChangeStartAtAttribute < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules, :start_at
    add_column :schedules, :date, :date
    add_column :schedules, :start_at, :string
  end
end
