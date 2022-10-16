# frozen_string_literal: true

class RenamePriceColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :plans, :price, :monthly_price
  end
end
