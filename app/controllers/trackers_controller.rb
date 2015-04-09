class TrackersController < ApplicationController
  
  # /trackers/logon
  def logon
    @computer = Computer.find_by_ip(request.remote_ip)
    if @computer.nil?
      @computer = Computer.new
      @computer.ip = request.remote_ip
    end
    @computer.logon(params[:username])
    @computer.save
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end

  # /trackers/logoff
  def logoff
    @computer = Computer.find_by_ip(request.remote_ip)
    if @computer.nil?
      @computer = Computer.new
      @computer.ip = request.remote_ip
    end
    @computer.logoff
    @computer.save
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
  
  # /trackers/ping
  def ping
    @computer = Computer.find_by_ip(request.remote_ip)
    if @computer.nil?
      @computer = Computer.new
      @computer.ip = request.remote_ip
    end
    @computer.ping
    @computer.save
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
end
