class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.decimal :price
      t.string :name
      t.string :notes

      t.timestamps
    end
  end
end
