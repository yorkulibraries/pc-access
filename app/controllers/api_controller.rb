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

end
