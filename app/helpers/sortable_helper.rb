module SortableHelper

  def sort_column
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sortable(column, title = nil)

    title ||= column.titleize

    if sort_column.to_s == column.to_s
      class_direction = "-#{sort_direction}"
      direction = sort_direction == "asc" ? "desc" : "asc"
    else
      class_direction = ""
      direction = "asc"
    end

    link_title = content_tag(:span) do
      concat title
      concat " <i class='fa fa-sort#{class_direction}'></i>".html_safe
    end

    link_to link_title, {sort: column, direction:  direction }
  end

end
