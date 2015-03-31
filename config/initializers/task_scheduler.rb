require 'rubygems'
require 'rufus/scheduler'
 
## to start scheduler
scheduler = Rufus::Scheduler.new
 
## It will print message every i minute
scheduler.every("1m") do
  Computer.where("current_username IS NOT NULL AND last_ping <= ?", 15.minutes.ago).each do |computer|
    Rails.logger.info "#{computer.last_ping}"
  end
end
