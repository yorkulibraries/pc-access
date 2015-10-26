class TrackersController < ApplicationController

  # /trackers/logon
  def logon
    @computer = Computer.where(ip: request.remote_ip).first_or_create
    @computer.logon(params[:username])
    @computer.save
    @computer.record_activity_log(ComputerActivityLog::ACTION_LOGON)

    respond_to do |format|
      format.all { render :nothing => true }
    end
  end

  # /trackers/logoff
  def logoff
    @computer = Computer.where(ip: request.remote_ip).first_or_create
    @computer.logoff
    @computer.save

    @computer.record_activity_log(ComputerActivityLog::ACTION_LOGOFF)

    respond_to do |format|
      format.all { render :nothing => true }
    end
  end

  # /trackers/ping
  def ping
    @computer = Computer.where(ip: request.remote_ip).first_or_create
    @computer.ping
    @computer.save  

    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
end
