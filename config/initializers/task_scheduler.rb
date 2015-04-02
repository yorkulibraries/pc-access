require 'rubygems'
require 'rufus/scheduler'
 
scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Computer.in_use.last_ping_more_than_x_time_ago(1.minutes).each do |computer|
    Rails.logger.debug "#{computer.ip} last_ping=#{computer.last_ping}"
    computer.logoff
    computer.save
  end
end
