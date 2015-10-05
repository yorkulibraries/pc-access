class Location < ActiveRecord::Base
  # FIELDS: name, map, ip_subnet, deleted

  ## RELATIONS
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :ip_subnet, uniqueness: true, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active images
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS
  # Attach computers to location based on IP and location's ip_subnet
  def attach_computers(only_computers_without_location = true)
    if only_computers_without_location
      Computer.where("location_id IS NULL").where("ip LIKE '#{self[:ip_subnet]}%'").update_all(location_id: self[:id])
    else
      Computer.where("ip LIKE '#{self[:ip_subnet]}%'").update_all(location_id: self[:id])
    end
  end

  # mock locations with maps
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
