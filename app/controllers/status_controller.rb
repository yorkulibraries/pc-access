class StatusController < ApplicationController

  def index
    @locations = Location.all
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
