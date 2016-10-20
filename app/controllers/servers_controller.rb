class ServersController < ApplicationController
  include SortableHelper

  before_action :set_server, only: [:show, :edit, :update, :destroy]

  def index
    sort_sql = sort_column

    if ActiveRecord::Base.connection.adapter_name == 'MySQL' && (sort_sql == "public_ip" || sort_sql == "local_ip") 
      sort_sql = "INET_ATON(#{sort_column})"
    end


    @servers = Server.order(sort_sql + " " + sort_direction)
  end

  def show
  end


  def new
    @server = Server.new
  end


  def edit
  end

  def create
    @server = Server.new(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.js
        format.json { respond_with_bip(@server) }
      else
        format.html { render :edit }
        format.js
        format.json { respond_with_bip(@server) }
      end
    end
  end

  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit(:hostname, :public_ip, :local_ip, :os_name, :note, :administrator, :public_ip_used, :local_ip_used)
    end

end
