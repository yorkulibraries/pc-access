module ApplicationHelper

  def app_version
    App::Version.new.version
  end

  def app_name
    "PC Access"
  end

  def format(field, simple_format = false)
    # If field is blank, print out blank message
    if field.blank?
      content_tag(:span, "Not filled in...", class: "empty-field")
    else
      if field.is_a? Date
        field.strftime("%B %d, %Y")
      else
        simple_format ? simple_format(field) : field
      end
    end
  end

  def path_to_url(path)
    separator = path.start_with?("/") ? "" : "/"
    "http://#{request.host_with_port}#{separator}#{path}"
  end

end
