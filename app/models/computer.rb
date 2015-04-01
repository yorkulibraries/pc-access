class Computer < ActiveRecord::Base
  belongs_to :location
  
  scope :in_use, -> { where("current_username IS NOT NULL") }
  scope :not_in_use, -> { where("current_username IS NULL") }
end
