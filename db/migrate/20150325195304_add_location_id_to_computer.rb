class AddLocationIdToComputer < ActiveRecord::Migration
  def change
    add_column :computers, :location_id, :integer
  end
end
