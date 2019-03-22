class TrackersController < ApplicationController

  # /trackers/logon
  def logon
    if params[:hostname]
      @computer = Computer.find_by_hostname(params[:hostname])
    end

    if @computer == nil
      @computer = Computer.where(ip: request.remote_ip).first_or_create(ip: request.remote_ip, hostname: params[:hostname])
      @computer.update_hostname_if_nil(params[:hostname])
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
      @computer = Computer.find_by_hostname(params[:hostname])
    end

    if @computer == nil
      @computer = Computer.where(ip: request.remote_ip).first_or_create(ip: request.remote_ip, hostname: params[:hostname])
      @computer.update_hostname_if_nil(params[:hostname])
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
    if params[:hostname]
      @computer = Computer.find_by_hostname(params[:hostname])
    end

    if @computer == nil
      @computer = Computer.where(ip: request.remote_ip).first_or_create(ip: request.remote_ip, hostname: params[:hostname])
      @computer.update_hostname_if_nil(params[:hostname])
    end

    @computer.ping
    @computer.save

    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
end
