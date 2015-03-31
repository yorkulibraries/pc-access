class TrackersController < ApplicationController
  
  # /trackers/logon
  def logon
    @computer = Computer.find_by_ip(request.remote_ip)
    if @computer.nil?
      @computer = Computer.new
      @computer.ip = request.remote_ip
    end
    username = !params['username'].nil? && params['username'].size ? params['username'] : request.remote_ip
    @computer.current_username = username
    @computer.last_ping = DateTime.now
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
    username = !params['username'].nil? && params['username'].size ? params['username'] : request.remote_ip
    @computer.current_username = nil
    @computer.last_ping = nil
    @computer.previous_username = username
    @computer.save
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
  
end
