class RemoveLogonTimeFromComputer < ActiveRecord::Migration
  def change
    remove_column :computers, :logon_time
  end
end
