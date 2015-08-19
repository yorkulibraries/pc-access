module ApplicationHelper

  def app_version
    PcAccess::Version.new.version
  end
end
