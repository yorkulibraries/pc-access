require 'rubygems'
require 'rufus/scheduler'
require 'net/ping'
 
scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Computer.in_use.last_ping_more_than_x_time_ago(15.minutes).each do |computer|
    #computer.logoff
    #computer.save
  end
  
  Computer.last_ping_more_than_x_time_ago(15.minutes) do |computer|
    Rails.logger.debug "Pinging #{computer.ip}"
    Net::Ping::TCP.econnrefused = true
    net = Net::Ping::TCP.new(computer.ip)
    if net.ping
      Rails.logger.debug "#{computer.ip} is alive"
      computer.is_powered_off = false
      computer.save
    else
      Rails.logger.debug "#{computer.ip} is off"
      computer.logoff
      computer.is_powered_off = true
      computer.save
    end
  end
end
