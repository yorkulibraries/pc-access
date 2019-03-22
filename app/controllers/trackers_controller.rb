class TrackersController < ApplicationController

  # /trackers/logon
  def logon
    if params[:hostname]
      @computer = Computer.where(hostname: params[:hostname]).first_or_create(hostname: params[:hostname], ip: request.remote_ip)
    else
      @computer = Computer.where(ip: request.remote_ip).first_or_create
    end

    @computer.logon(params[:username])
    @computer.save
    @computer.record_activity_log(ComputerActivityLog::ACTION_LOGON)

    respond_to do |format|
      format.all { render :nothing => true }
    end
  end

  # /trackers/logoff
  def logoff

    if params[:hostname]
      @computer = Computer.where(hostname: params[:hostname]).first_or_create(hostname: params[:hostname], ip: request.remote_ip)
    else
      @computer = Computer.where(ip: request.remote_ip).first_or_create
    end

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
