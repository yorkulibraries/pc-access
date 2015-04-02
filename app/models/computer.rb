class Computer < ActiveRecord::Base
  belongs_to :location
  
  scope :in_use, -> { where("current_username IS NOT NULL AND is_powered_off = ?", false) }
  scope :not_in_use, -> { where("current_username IS NULL OR is_powered_off = ?", true) }
  scope :last_ping_more_than_x_time_ago, ->(time) { where("last_ping < ?", time.ago) }
  scope :powered_off, -> { where("is_powered_off = ?", true) }
  
  def logon(username)
    self.current_username = username
    self.last_ping = DateTime.now
  end
  
  def logoff
    self.previous_username = self.current_username
    self.current_username = nil
    self.last_ping = nil
  end
end
