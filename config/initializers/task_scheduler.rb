require 'rubygems'
require 'rufus/scheduler'
 
scheduler = Rufus::Scheduler.new
# run every minute
scheduler.every("1m") do
  # get all computers that have not "ping'ed" the server within the last 16 minutes
  # and flag them as available
  Computer.where("current_username IS NOT NULL AND last_ping < ?", 16.minutes.ago).each do |computer|
    Rails.logger.debug "#{computer.ip} last_ping=#{computer.last_ping} - not-in-used"
    computer.last_ping = nil
    computer.last_username = computer.current_username
    computer.current_username = nil
    computer.save
  end
end
