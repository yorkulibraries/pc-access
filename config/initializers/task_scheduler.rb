require 'rubygems'
require 'rufus/scheduler'
 
## to start scheduler
scheduler = Rufus::Scheduler.new
 
## It will print message every i minute
scheduler.every("5m") do
puts("HELLO #{Time.now}")
end
