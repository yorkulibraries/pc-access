require 'rubygems'
require 'rufus/scheduler'
 
scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Computer.in_use.last_ping_more_than_x_time_ago(15.minutes).each do |computer|
    computer.logoff
    computer.save
  end
end
