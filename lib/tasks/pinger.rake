namespace :computer do
  desc "Runs through computer list and pings them randomly, at specified intervals"


  task :pinger => :environment do
    SLEEP_TIME = 60

    computers = Computer.all

    count = computers.size

    log "Processing #{count} computers"

    1000.times  do |i|
      computers.each do |c|
        c.ping

        m = c.id + i
        if m.modulo(4).zero?
          # active by user
          log "Active user", true
          c.logon("test")
        elsif m.modulo(3).zero?
          # log off
          log "Log off, not active anymore", true
          c.logoff()
        elsif m.modulo(7).zero?
          # never used
          log "never used", true
          c.last_user_activity = nil
        elsif m.modulo(10).zero?
          log "Pinging", true
          c.ping
        else
          log "Never ping", true
          c.last_ping = nil
        end

        c.save(validate: false)
      end

      log "In Use: #{computers.in_use.size}  Not In Use: #{computers.not_in_use.size}"
      log "Active: #{computers.staying_active.size}  Inactive: #{computers.not_staying_active.size}"
      log "Pinging: #{computers.pinging.size}  Not pinging: #{computers.not_pinging.size}"
      log "Never Pinging: #{computers.never_ping.size}  Never active: #{computers.never_used.size}"

      sleep(SLEEP_TIME)
    end

  end

  def log(text, same_line=false)

    if same_line
      STDOUT.write "\r#{text}"
    else
      puts text
    end

  end
end
