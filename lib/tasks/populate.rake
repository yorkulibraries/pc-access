namespace :db do
  desc "Database Populate Tasks, Test Data"


  task :populate => :environment do
    require 'populator'
    require 'faker'

    puts "Deleting previous data"
    [ Computer, Image, Location ].each(&:delete_all)

    index = 0

    puts "Prefil Locations"
    maps = [ "https://www.library.yorku.ca/preview/images/maps/scott-1stfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-2ndfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-3rdfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-4thfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-5thfloor.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-east-asian-collection.jpg",
      "https://www.library.yorku.ca/preview/images/maps/scott-reserves.jpg"
    ]

    Location.populate maps.size do |loc, index|
      loc.name = File.basename(maps[index-1], '.jpg').gsub(/-/, ' ').humanize
      loc.map = maps[index-1]
      loc.ip_subnet = ["255", "180", "130", "63", "2", "3"]
      loc.id = index
    end

    puts "Prefil Images"
    Image.populate 3 do |image, index|
      image.name = ["Windows", "Linux", "OS X"]
      image.os_version = ["1", "2", "3"]
      image.os_name = image.name
    end

    puts "Prefil Computers"

    Computer.populate 100 do |c, index|
      num = index + 10
      c.ip = "130.63.180.#{num}"
      c.current_username = "user_#{num}" if num.to_i.even?
      c.current_username = nil unless num.to_i.even?
      c.previous_username = nil if num.to_i.even?
      c.previous_username = "user_#{num-2}" unless num.to_i.even?

      c.last_ping =  3.minutes.ago..1.days.ago
      c.last_user_activity = 10.minutes.ago..3.days.ago
      c.location_id = 1..maps.size

    end





  end
end
