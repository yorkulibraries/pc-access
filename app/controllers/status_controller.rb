class StatusController < ApplicationController
  
  def index
    @in_use = Computer.in_use
    @not_in_use = Computer.not_in_use
    status = { in_use_count: @in_use.size, in_use: @in_use, not_in_use_count: @not_in_use.size, not_in_use: @not_in_use }
    respond_to do |format|
      format.html
      format.json { render :json => status }
    end
  end

end