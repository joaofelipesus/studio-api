# frozen_string_literal: true

class RecreateStudent < ActiveRecord::Migration[7.0]
  def change
    remove_reference :students, :user

    add_column :students, :name, :string
    add_reference :students, :objective, type: :uuid, index: true
  end
end
