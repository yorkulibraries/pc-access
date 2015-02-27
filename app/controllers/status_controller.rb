class StatusController < ApplicationController
  
  def index
    occupied = Tracker.all
    status = { :occupied => occupied }
    respond_to do |format|
      format.json { render :json => status }
    end
  end

end
