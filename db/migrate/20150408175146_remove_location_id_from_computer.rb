class RemoveLocationIdFromComputer < ActiveRecord::Migration
  def change
    remove_column :computers, :location_id
  end
end
