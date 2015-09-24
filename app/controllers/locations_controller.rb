class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
      @locations = Location.all
    end

    def show
    end

    def new
      @location = Location.new
    end

    def edit
    end

    def create
      @location = Location.new(location_params)
      #@location.is_deleted = false

      respond_to do |format|
        if @location.save
          format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
          # format.json { render action: 'show', status: :created, location: @location }
        else
          format.html { render action: 'new' }
          # format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end

    end

    def update
      respond_to do |format|

        if @location.update(location_params)
          format.html { redirect_to locations_path, notice: 'Location was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @location.destroy
      #@location = Location.find(params[:id])

      # @location.is_deleted = true

      respond_to do |format|
        if @location.save
          format.html { redirect_to locations_path, notice: 'Location was successfully flagged as deleted and removed from the list.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:id])
      end

      def location_params
        params.require(:location).permit( :name, :ip_subnet, :map)
      end


end
