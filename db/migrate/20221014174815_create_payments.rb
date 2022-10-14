class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :student_plan, null: false, foreign_key: true, type: :uuid
      t.string :payment_method
      t.date :date

      t.timestamps
    end
  end
end
