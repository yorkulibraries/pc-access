class TrackersController < ApplicationController
  
  # /trackers/logon
  def logon
    if not Tracker.exists?(:ip => request.remote_ip)
      @tracker = Tracker.new
      @tracker.ip = request.remote_ip
      @tracker.save
    end
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end

  # /trackers/logoff
  def logoff
    Tracker.where(:ip => request.remote_ip).destroy_all
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
  
end
