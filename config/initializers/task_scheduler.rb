require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Rails.logger.debug("Task scheduler running at: #{Time.now}")

end
