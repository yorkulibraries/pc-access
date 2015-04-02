class AddIsPoweredOffToComputer < ActiveRecord::Migration
  def change
    add_column(:computers, :is_powered_off, :boolean)
  end
end
