class Location < ActiveRecord::Base
  # FIELDS: name, map, ip_subnet

  ## RELATIONS
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :ip_subnet, presence: true

  ## SCOPES






  ## METHODS

  ##
  def self.mock_locations
    maps = [ "https://www.library.yorku.ca/preview/images/maps/scott-1stfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-2ndfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-3rdfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-4thfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-5thfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-east-asian-collection.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-reserves.jpg"
    ]

    locations = Array.new
    maps.each do |map|
      name = File.basename(map, '.jpg').gsub(/-/, ' ').humanize
      locations.push Location.new(name: name, map: map)

    end

    return locations
  end

end
