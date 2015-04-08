require 'rubygems'
require 'rufus/scheduler'
require 'net/ping'

scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Rails.logger.debug("Task scheduler running at: #{Time.now}")
  
  Computer.in_use.last_ping_more_than_x_time_ago(15.minutes).each do |computer|
    ip = computer.ip

    Rails.logger.debug "Logoff #{ip}"
    computer.logoff

    Rails.logger.debug "Pinging #{ip}"
    Net::Ping::TCP.econnrefused = true
    net = Net::Ping::TCP.new(ip, 135 , 1)
    if net.ping?
      Rails.logger.debug "#{ip} is alive"
      computer.is_powered_off = false
    else
      Rails.logger.debug "#{ip} is off"
      computer.power_off
    end
    
    computer.save
  end
  
  Computer.powered_off.each do |computer|
    ip = computer.ip
    Rails.logger.debug "Pinging #{ip}"
    Net::Ping::TCP.econnrefused = true
    net = Net::Ping::TCP.new(ip, 135 , 1)
    if net.ping?
      Rails.logger.debug "#{ip} is alive"
      computer.is_powered_off = false
    end
    computer.save
  end
end
