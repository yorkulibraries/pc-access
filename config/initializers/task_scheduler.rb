require 'rubygems'
require 'rufus/scheduler'
 
## to start scheduler
scheduler = Rufus::Scheduler.new
 
## It will print message every i minute
scheduler.every("1m") do
  Rails.logger.info "#{Time.now}"
end
