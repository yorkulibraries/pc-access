class AddDefaultValueToComputerIsPoweredOff < ActiveRecord::Migration
  def change
    change_column :computers, :is_powered_off, :boolean, :default => false
  end
end
