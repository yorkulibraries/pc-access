title "All Locations"


for location in @locations
  xml.item do

    xml.author "Library Computers"
    xml.pubDate Date.today
    #xml.link "#{location.map}"
    #xml.guid "#{location.map}"

    html  =  render(partial: "locations/location", :formats => [:html], locals: { show: "public", location: location  })
    xml.description { xml.cdata!(html) }
  end
end
