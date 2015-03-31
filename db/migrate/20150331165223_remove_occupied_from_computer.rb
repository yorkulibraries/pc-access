class RemoveOccupiedFromComputer < ActiveRecord::Migration
  def change
    remove_column :computers, :occupied
  end
end
