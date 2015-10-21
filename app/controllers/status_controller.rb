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

  def by_status
    @status_name = params[:status].humanize
    
    case params[:status]
    when "in_use"
      @computers = Computer.in_use
    when "not_in_use"
      @computers = Computer.not_in_use
    when "pinging"
      @computers = Computer.pinging
    when "not_pinging"
      @computers = Computer.not_pinging
    when "staying_active"
      @computers = Computer.staying_active
    when "not_staying_active"
      @computers = Computer.not_staying_active
    when "never_ping"
      @computers = Computer.never_ping
    when "never_used"
      @computers = Computer.never_used
    else
      @computers = Computer.in_use
    end

  end

end
