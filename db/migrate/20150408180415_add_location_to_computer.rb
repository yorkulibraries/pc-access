class AddLocationToComputer < ActiveRecord::Migration
  def change
    add_reference :computers, :location, index: true
    add_foreign_key :computers, :locations
  end
end
