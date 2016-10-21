namespace :server do
  desc "Database Servers"


  task :populate => :environment do
    require 'resolv'

    range = 2..254

    range.each do |num|
      public_ip = "130.63.180.#{num}"
      local_ip = "10.0.0.#{num}"

      begin
        hostname = Resolv.new.getname(public_ip)
        puts "Found #{hostname} - #{public_ip}"
      rescue
        puts "No DNS for IP: #{public_ip}"
        hostname = ""
      end

      server = Server.find_by_public_ip(public_ip)

      if server
        server.update_attribute(:hostname, hostname)
      else
        server = Server.new()
        server.hostname = hostname
        server.public_ip = public_ip
        server.public_ip_used = true

        server.local_hostname = ""
        server.local_ip = local_ip        
        server.local_ip_used = false

        server.last_ping = Date.today
        server.save(validate: false)
      end

    end

  end
end
