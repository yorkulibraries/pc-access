namespace :computer do
  desc "Runs through computer list and pings them randomly, at specified intervals"


  task :pinger => :environment do
    SLEEP_TIME = 60

    computers = Computer.all

    count = computers.size

    puts "Processing #{count} computers"

    1000.times  do |i|
      computers.each do |c|
        m = c.id + i
        if m.modulo(4).zero?
          # active by user
          puts "Active user"
          c.logon("test")
        elsif m.modulo(3).zero?
          # log off
          puts "Log off, not active anymore"
          c.logoff()
        elsif m.modulo(7).zero?
          # never used
          puts "never used"
          c.last_user_activity = nil
        elsif m.modulo(10).zero?
          puts "Pinging"
          c.ping
        else
          puts "Never ping"
          c.last_ping = nil
        end

        c.save(validate: false)
      end

      sleep(SLEEP_TIME)
    end

  end
end
