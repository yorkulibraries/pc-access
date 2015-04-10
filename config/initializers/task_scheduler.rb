require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Rails.logger.info("Task scheduler running at: #{Time.now}")
  
  Computer.free_inactive_computers
end
