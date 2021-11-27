# frozen_string_literal: true

class CreateMuscularGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :muscular_groups, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
