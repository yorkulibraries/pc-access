class ComputersController < ApplicationController

  before_action :set_computer, except: [:index, :new, :create]

  def index
    @computers = Computer.all
  end

  def show
    @logs = @computer.activity_entries.limit(300)
  end

  private
  def set_computer
    @computer = Computer.find(params[:id])
  end

end
