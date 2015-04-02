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
  
  Computer.find_each do |computer|
    icmp = Net::Ping::ICMP.new(computer.ip)
    if !icmp.ping
      computer.logoff
      computer.is_powered_off = true
      computer.save
    end
  end
end
