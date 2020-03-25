module ApplicationHelper

  def show_menu?(project)
    project.try(:id) || false
  end

end
