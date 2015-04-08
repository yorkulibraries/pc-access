class AddLogonTimeToComputer < ActiveRecord::Migration
  def change
    add_column(:computers, :logon_time, :datetime)
  end
end
