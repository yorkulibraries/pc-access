module ApplicationHelper

  def app_version
    App::Version.new.version
  end

  def app_name
    "PC Access"
  end
end
