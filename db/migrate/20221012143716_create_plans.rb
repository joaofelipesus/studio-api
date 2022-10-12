class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.timestamps

      t.string :name
      t.float :value
    end
  end
end
