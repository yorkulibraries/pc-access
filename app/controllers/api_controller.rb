class ApiController < ApplicationController

    def index
      @locations = [ {name: "Scott", available: 0, in_use: 10},
                     {name: "Steacie", available: 10, in_use: 4},
                     {name: "Bronfman", available: 4, in_use: 0} 
                   ]

      respond_to do |format|
        format.rss
      end
    end

end
