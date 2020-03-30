class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :bill_id
      t.datetime :payment_date
      t.decimal :payment_amount
      t.integer :contact_id
      t.integer :payment_type

      t.timestamps
    end
  end
end
