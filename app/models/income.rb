class Income < ApplicationRecord
  belongs_to :contact
  belongs_to :project

  after_save :update_project_total_incomes
  after_destroy :update_project_total_incomes

  def update_project_total_incomes
    self.project.total_incomes = self.project.incomes.calculate(:sum, :amount)
    self.project.save!
  end

end
