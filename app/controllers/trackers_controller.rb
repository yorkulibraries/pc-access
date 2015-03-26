class TrackersController < ApplicationController
  
  # /trackers/logon
  def logon
    @computer = Computer.find_by_ip(request.remote_ip)
    if @computer.nil?
      @computer = Computer.new
      @computer.ip = request.remote_ip
    end
    @computer.occupied = true
    @computer.current_username = params['username']
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
    @computer.occupied = false
    @computer.current_username = nil
    @computer.previous_username = params['username']
    @computer.save
    respond_to do |format|
      format.all { render :nothing => true }
    end
  end
  
end
