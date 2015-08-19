module ApplicationHelper

  def app_version
    App::Version.new.version
  end
end
