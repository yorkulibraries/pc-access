class ApiController < ApplicationController
    protect_from_forgery unless: -> { request.format.js? }

    after_action do
      response.headers['X-Frame-Options'] = 'GOFORIT'
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

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

      respond_to do |format|
        format.html { render layout: "public" }
        format.js
      end
    end

    def by_floor
      @location = Location.find(params[:id])
      @floor = @location.floors.find(params[:floor_id])

      respond_to do |format|
        format.html { render layout: "public" }
        format.js
      end

    end

    def by_area
      @location = Location.find(params[:id])
      @area = @location.areas.find(params[:area_id])

      respond_to do |format|
        format.html { render layout: "public" }
        format.js
      end
    end

    def preview

      @locations = Location.all

      render layout: "public"
    end

end
