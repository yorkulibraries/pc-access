#encoding: UTF-8
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    title = content_for?(:title) ? yield(:title) : "By Location"
    xml.title "Library Computers - " + title
    xml.author "Lib Comp"
    #rxml.description "Software-Development, Mobiles Devices, Photography"
    xml.link "https://library.yorku.ca"
    xml.language "en"

      xml << yield

  end
end
