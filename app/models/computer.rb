class Computer < ActiveRecord::Base
  belongs_to :location
  
  scope :in_use, -> { where("current_username IS NOT NULL") }
  scope :not_in_use, -> { where("current_username IS NULL") }
  scope :last_ping_more_than_x_time_ago, ->(time) { where("last_ping < ?", time.ago) }
end
