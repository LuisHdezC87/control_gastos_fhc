module ProjectsHelper

  def number_of_incomes(project)
    project.incomes.count || 0
  end

end
