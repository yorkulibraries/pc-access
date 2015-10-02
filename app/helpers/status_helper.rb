module StatusHelper

  def location_activity_chart_data

    @locations = Location.all
    comps = Array.new

    @locations.each do |loc|

      comps.push ({
        location: loc.name,
        total_computers: loc.computers.size,
        active_computers: loc.computers.staying_active.size,
        not_in_use_computers: loc.computers.not_in_use.size
      })

    end

    return comps
  end

  def by_status_of_activity_chart_data

    [
      { status: "Pinging", value: Computer.pinging.size },
      { status: "Not Pinging", value: Computer.not_pinging.size },
      { status: "Staying Active", value: Computer.staying_active.size },
      { status: "Not Staying Active", value: Computer.not_staying_active.size }
    ]

  end



  def troubled_computers_chart_data
    [
      { label: "Never Used", value: Computer.never_used.size },
      { label: "Never Ping", value: Computer.never_ping.size }
      ]
  end
end
