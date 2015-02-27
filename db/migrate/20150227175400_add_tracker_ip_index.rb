class AddTrackerIpIndex < ActiveRecord::Migration
  def change
    add_index :trackers, :ip
  end
end
