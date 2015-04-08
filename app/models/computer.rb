class Computer < ActiveRecord::Base
  belongs_to :location
  
  scope :in_use, -> { where("current_username IS NOT NULL AND is_powered_off = ?", false) }
  scope :not_in_use, -> { where("current_username IS NULL OR is_powered_off = ?", true) }
  scope :last_ping_more_than_x_time_ago, ->(time) { where("last_ping IS NOT NULL AND last_ping < ?", time.ago) }
  scope :powered_off, -> { where("is_powered_off = ?", true) }
  
  def logon(username)
    self.current_username = username
    self.last_ping = DateTime.now
    self.is_powered_off = false
  end
  
  def logoff
    if !self.current_username.nil?
      self.previous_username = self.current_username
    end
    self.current_username = nil
    self.last_ping = nil
  end
  
  def power_off
    self.logoff
    self.is_powered_off = true
  end
  
  def is_in_use
    return !self.current_username.nil?
  end
end
