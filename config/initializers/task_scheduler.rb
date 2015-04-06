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
  
  Computer.in_use.last_ping_more_than_x_time_ago(15.minutes).each do |computer|
    ip = computer.ip
    Rails.logger.debug "Pinging #{ip}"
    Net::Ping::TCP.econnrefused = true
    net = Net::Ping::TCP.new(ip)
    if net.ping?
      Rails.logger.debug "#{ip} is alive"
      computer.is_powered_off = false
      computer.save
    else
      Rails.logger.debug "#{ip} is off"
      computer.power_off
      computer.save
    end
  end
end
