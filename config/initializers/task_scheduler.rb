require 'rubygems'
require 'rufus/scheduler'
require 'ping'
 
scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Computer.in_use.last_ping_more_than_x_time_ago(15.minutes).each do |computer|
    #computer.logoff
    #computer.save
  end
  
  Computer.find_each do |computer|
    Rails.logger.debug "Pinging #{computer.ip}"
    if !Ping.pingecho(computer.ip)
      Rails.logger.debug "#{computer.ip} did not reply"
      computer.logoff
      computer.is_powered_off = true
      computer.save
    end
  end
end
