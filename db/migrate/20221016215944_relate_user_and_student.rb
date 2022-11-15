# frozen_string_literal: true

class RelateUserAndStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :user, type: :uuid, index: true, null: true, default: nil
  end
end
