class AddLastKeepAliveToComputer < ActiveRecord::Migration
  def change
    add_column :computers, :last_user_activity, :datetime
  end
end
