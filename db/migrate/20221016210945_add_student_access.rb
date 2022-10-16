# frozen_string_literal: true

class AddStudentAccess < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :has_access, :boolean, default: false
  end
end
