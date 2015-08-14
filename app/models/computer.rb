require "ipaddress"

class Computer < ActiveRecord::Base

  ## CONSTANTS
  KEEP_ALIVE_INTERVAL = Rails.application.config.keep_alive_interval # 15.minutes

  ## RELATIONS
  belongs_to :location

  ## VALIDATIONS
  validates :ip, :presence => true, :uniqueness => true
  validate :valid_ip

  ## SCOPES

  scope :in_use, -> { where("current_username IS NOT NULL") }
  scope :not_in_use, -> { where("current_username IS NULL") }
  scope :not_keeping_alive, -> { where("last_keep_alive < ?", Computer::KEEP_ALIVE_INTERVAL.ago) }
  scope :keeping_alive, -> { where("last_keep_alive >= ?", Computer::KEEP_ALIVE_INTERVAL.ago) }
  scope :not_pinging, -> { where("last_ping < ?", Computer::KEEP_ALIVE_INTERVAL.ago) }
  scope :pinging, -> { where("last_ping >= ?", Computer::KEEP_ALIVE_INTERVAL.ago) }
  scope :never_ping, -> { where("last_ping IS NULL") }
  scope :never_used, -> { where("last_keep_alive IS NULL") }

  def self.free_inactive_computers
    self.in_use.not_keeping_alive.each do |pc|
      Rails.logger.info("#{pc.ip} not_keeping_alive => logging off")
      pc.logoff
      pc.save
    end
  end

  def logon(username)
    if self.current_username != username
      self.current_username = username
    end
    self.keep_alive
  end

  def logoff
    self.previous_username = self.current_username unless self.current_username.nil?
    self.current_username = nil
  end

  def is_in_use
    return !self.current_username.nil?
  end

  def ping
    self.last_ping = DateTime.now
  end

  def keep_alive
    self.last_keep_alive = DateTime.now
  end

  private
  def valid_ip
    unless IPAddress.valid?(ip)
      errors.add(:ip, "Invalid IP address")
    end
  end
end
