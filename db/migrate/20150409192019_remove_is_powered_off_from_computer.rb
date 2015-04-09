class RemoveIsPoweredOffFromComputer < ActiveRecord::Migration
  def change
    remove_column :computers, :is_powered_off
  end
end
