class StatusController < ApplicationController
  
  def index
    occupied = Computer.where(occupied: true).all
    available = Computer.where(occupied: false).all
    status = { occupied_count: occupied.size, occupied: occupied, available_count: available.size, available: available }
    respond_to do |format|
      format.json { render :json => status }
    end
  end

end
