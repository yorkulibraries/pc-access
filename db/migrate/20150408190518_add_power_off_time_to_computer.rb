class AddPowerOffTimeToComputer < ActiveRecord::Migration
  def change
    add_column(:computers, :power_off_time, :datetime)
  end
end
