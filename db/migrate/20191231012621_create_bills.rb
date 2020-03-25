class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.integer :project_id
      t.decimal :total_amount
      t.date :purchase_date
      t.integer :contact_id
      t.integer :bill_type_id

      t.timestamps
    end
  end
end
