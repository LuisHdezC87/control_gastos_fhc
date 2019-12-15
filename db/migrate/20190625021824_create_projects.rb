class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.decimal :total
      t.datetime :init_date
      t.datetime :final_date
      t.datetime :last_update

      t.timestamps
    end
  end
end
