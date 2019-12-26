class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.integer :project_id
      t.decimal :amount, scale: 2, precision: 12, default: 0
      t.integer :contact_id
      t.string :notes
      t.datetime :date

      t.timestamps
    end
  end
end
