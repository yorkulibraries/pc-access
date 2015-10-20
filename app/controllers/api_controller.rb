class ApiController < ApplicationController

    def index
      locations_list = Location.mock_locations

      @locations = Array.new
      locations_list.each do |location|
        l = { location: location, available: rand(0..10), in_use: rand(0..20) }
        @locations.push l
      end


      respond_to do |format|
        format.rss
      end
    end

    def by_location
      @location = Location.find(params[:id])
    end

    def by_floor
      @location = Location.find(params[:id])
      @floor = @location.floors.find(params[:floor_id])
    end

end
