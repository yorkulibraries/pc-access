require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

# run every minute
scheduler.every("1m") do
  Rails.logger.info("Task scheduler running at: #{Time.now}")
  
  Computer.in_use.keep_alive_timed_out.each do |pc|
    Rails.logger.info("#{pc.ip} keep_alive_timed_out => logging off")
    pc.logoff
    pc.save
  end
end
