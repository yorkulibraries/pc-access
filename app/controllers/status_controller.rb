class StatusController < ApplicationController
  
  def index
    @in_use = Computer.in_use
    @not_in_use = Computer.not_in_use
    @not_pinging = Computer.not_pinging
    @pinging = Computer.pinging
    @keeping_alive = Computer.keeping_alive
    @not_keeping_alive = Computer.not_keeping_alive
    @never_ping = Computer.never_ping
    status = { 
      in_use: @in_use, 
      not_in_use: @not_in_use,
      not_pinging: @not_pinging,
      pinging: @pinging,
      keeping_alive: @keeping_alive,
      not_keeping_alive: @not_keeping_alive
    }
    respond_to do |format|
      format.html
      format.json { render :json => status }
    end
  end

end
