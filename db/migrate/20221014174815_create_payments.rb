class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.timestamps

      t.references :student_plan, null: false, foreign_key: true, type: :uuid
      t.references :personal, null: false, foreign_key: true, type: :uuid

      t.string :payment_method
      t.date :date
      t.decimal :amount, precision: 10, scale: 2
    end
  end
end
