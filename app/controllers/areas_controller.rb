class AreasController < ApplicationController

  before_action :set_location
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
      @areas = @location.areas
    end

    def show
    end

    def new
      @area = @location.areas.build
    end

    def edit
    end

    def create
      @area = @location.areas.build(area_params)

      respond_to do |format|
        if @area.save
          format.html { redirect_to location_areas_path(@location), notice: 'Area was successfully created.' }
          format.js
        else
          format.html { render action: 'new' }
          format.js
        end
      end

    end

    def update
      respond_to do |format|

        if @area.update(area_params)
          format.html { redirect_to location_areas_path(@location), notice: 'area was successfully updated.' }
          format.js
        else
          format.html { render action: 'edit' }
          format.js
        end
      end
    end

    def destroy
      @area.deleted = true
      @area.save(validate: false)


      respond_to do |format|
          format.html { redirect_to location_areas_path(@location), notice: 'Area was successfully deleted and removed from the list.' }
          format.js
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:location_id])
      end

      def set_area
        @area = @location.areas.find(params[:id])
      end

      def area_params
        params.require(:area).permit( :name, :department, :specia_access, :map, :notes, :floor_id)
      end


end
