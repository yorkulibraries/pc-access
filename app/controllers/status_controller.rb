class StatusController < ApplicationController
  
  def index
    @in_use = Computer.in_use
    @not_in_use = Computer.not_in_use
    @not_pinging = Computer.not_pinging
    @pinging = Computer.pinging
    @staying_active = Computer.staying_active
    @not_staying_active = Computer.not_staying_active
    @never_ping = Computer.never_ping
    @never_used = Computer.never_used
    status = { 
      in_use: @in_use, 
      not_in_use: @not_in_use,
      not_pinging: @not_pinging,
      pinging: @pinging,
      staying_active: @staying_active,
      not_staying_active: @not_staying_active
    }
    respond_to do |format|
      format.html
      format.json { render :json => status }
    end
  end

end
