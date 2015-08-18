
for location in @locations
  xml.item do

    xml.author "Library Computers"
    xml.pubDate Date.today
    xml.link "https://#{location[:name]}"
    xml.guid "some_id"
    text = "<h1>#{location[:name]}</h1>"
    text <<  "<p>Available: #{location[:available]}<br/>In Use:  #{location[:in_use]}</p>"
    xml.description text
  end
end
