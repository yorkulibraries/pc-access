class AddLastPingToComputer < ActiveRecord::Migration
  def change
    add_column(:computers, :last_ping, :datetime)
  end
end
