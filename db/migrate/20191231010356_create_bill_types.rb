class CreateBillTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_types do |t|
      t.integer :project_id
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
