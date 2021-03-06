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

      respond_to do |format|
        if @location.save
          format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
          format.js
        else
          format.html { render action: 'new' }
          format.js
        end
      end

    end

    def update
      respond_to do |format|

        if @location.update(location_params)
          format.html { redirect_to locations_path, notice: 'Location was successfully updated.' }
          format.js
        else
          format.html { render action: 'edit' }
          format.js
        end
      end
    end

    def destroy
      @location.deleted = true
      @location.save(validate: false)


      respond_to do |format|
          format.html { redirect_to locations_path, notice: 'Location was successfully deleted and removed from the list.' }
          format.js
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:id])
      end

      def location_params
        params.require(:location).permit( :name, :ip_subnets, :address, :floors)
      end


end
