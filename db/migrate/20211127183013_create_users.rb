# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.string :status, default: 'PENDING'
      t.string :name
      t.string :confirmation_token
      t.datetime :last_login
      t.datetime :confirmed_at
      t.string :kind

      t.timestamps
    end
  end
end
