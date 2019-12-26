class AddTotalIncomesToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :total_incomes, :decimal
  end
end
