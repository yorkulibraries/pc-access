title "All Locations"


for entry in @locations
  xml.item do

    xml.author "Library Computers"
    xml.pubDate Date.today
    xml.link "#{entry[:location].map}"
    xml.guid "#{entry[:location].map}"

    html = "<div class='computers_availablity_by_location'>"
    html << "<img src='#{entry[:location].map}'/>"
    html << "<h3>#{entry[:location].name}</h3>"
    html <<  "<p>Available: #{entry[:available]}<br/>In Use:  #{entry[:in_use]}</p>"
    html << "</div>"
    xml.description { xml.cdata!(html) }
  end
end
