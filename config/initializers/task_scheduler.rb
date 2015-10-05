require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Rails.logger.info("Task scheduler running at: #{Time.now}")

  Computer.free_inactive_computers
end


scheduler.every("10m") do
  Rails.logger.info("Task scheduler running at: #{Time.now}")

  Computer.all.each do |c|
    c.attach_to_location
  end
end
