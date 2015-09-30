require "ipaddress"

class Computer < ActiveRecord::Base

  ## CONSTANTS
  STAY_ALIVE_INTERVAL = Rails.application.config.stay_alive_interval # 15.minutes

  ## RELATIONS
  belongs_to :location
  belongs_to :image

  ## VALIDATIONS
  validates :ip, :presence => true, :uniqueness => true
  validate :valid_ip

  ## SCOPES

  scope :in_use, -> { where("current_username IS NOT NULL") }
  scope :not_in_use, -> { where("current_username IS NULL") }
  scope :not_staying_active, -> { where("last_user_activity < ?", Computer::STAY_ALIVE_INTERVAL.ago) }
  scope :staying_active, -> { where("last_user_activity >= ?", Computer::STAY_ALIVE_INTERVAL.ago) }
  scope :not_pinging, -> { where("last_ping < ?", Computer::STAY_ALIVE_INTERVAL.ago) }
  scope :pinging, -> { where("last_ping >= ?", Computer::STAY_ALIVE_INTERVAL.ago) }
  scope :never_ping, -> { where("last_ping IS NULL") }
  scope :never_used, -> { where("last_user_activity IS NULL") }

  ## CALLBACKS
  after_create :attach_to_location

  ## METHODS
  def attach_to_location
    Location.all.each do |loc|
      if self[:ip].start_with?(loc.ip_subnet)
        update_attribute(:location_id, loc.id)
      end
    end
  end

  def self.free_inactive_computers
    self.in_use.not_staying_active.each do |pc|
      Rails.logger.info("#{pc.ip} not_staying_active => logging off")
      pc.logoff
      pc.save
    end
  end

  def logon(username)
    if self.current_username != username
      self.current_username = username
    end
    self.stay_alive
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

  def stay_alive
    self.last_user_activity = DateTime.now
  end

  private
  def valid_ip
    unless IPAddress.valid?(ip)
      errors.add(:ip, "Invalid IP address")
    end
  end
end
