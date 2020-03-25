class CreateBillRows < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_rows do |t|
      t.decimal :price
      t.integer :product_id
      t.decimal :amount

      t.timestamps
    end
  end
end
