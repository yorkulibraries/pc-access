class FloorsController < ApplicationController
  before_action :set_location
  before_action :set_floor, only: [:show, :edit, :update, :destroy]

  def index
      @floors = @location.floors
    end

    def show
    end

    def new
      @floor = @location.floors.build
    end

    def edit
    end

    def create
      @floor = @location.floors.build(floor_params)

      respond_to do |format|
        if @floor.save
          format.html { redirect_to location_floors_path(@location), notice: 'Floor was successfully created.' }
          format.js
        else
          format.html { render action: 'new' }
          format.js
        end
      end

    end

    def update
      respond_to do |format|

        if @floor.update(floor_params)
          format.html { redirect_to location_floors_path(@location), notice: 'Floor was successfully updated.' }
          format.js
        else
          format.html { render action: 'edit' }
          format.js
        end
      end
    end

    def destroy
      @floor.deleted = true
      @floor.save(validate: false)


      respond_to do |format|
          format.html { redirect_to location_floors_path(@location), notice: 'Floor was successfully deleted and removed from the list.' }
          format.js
      end
    end

    ## ADDITIONAL METHODS ##
    def sort
      params[:floor].each_with_index do |id, index|
         @location.floors.where(id: id).update_all({position: index + 1} )
      end
      render nothing: true
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:location_id])
      end

      def set_floor
        @floor = @location.floors.find(params[:id])
      end

      def floor_params
        params.require(:floor).permit( :name, :position, :map)
      end

end
