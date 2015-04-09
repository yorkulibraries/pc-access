class RemovePowerOnOffFromComputer < ActiveRecord::Migration
  def change
    remove_column :computers, :power_on_time
    remove_column :computers, :power_off_time
  end
end
