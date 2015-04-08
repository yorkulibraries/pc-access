class AddPowerOnTimeToComputer < ActiveRecord::Migration
  def change
    add_column(:computers, :power_on_time, :datetime)
  end
end
