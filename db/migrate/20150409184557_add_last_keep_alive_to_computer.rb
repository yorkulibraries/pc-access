class AddLastKeepAliveToComputer < ActiveRecord::Migration
  def change
    add_column :computers, :last_keep_alive, :datetime
  end
end
