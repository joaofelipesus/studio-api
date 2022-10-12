class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.timestamps

      t.string :name
      t.float :price
      t.integer :duration_in_months

      t.references :personal, null: false, foreign_key: true, type: :uuid
    end
  end
end
