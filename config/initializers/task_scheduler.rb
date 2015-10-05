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

  Location.all.each do |l|
    l.attach_computers(false)
  end
end
