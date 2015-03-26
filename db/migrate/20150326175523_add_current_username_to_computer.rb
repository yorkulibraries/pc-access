class AddCurrentUsernameToComputer < ActiveRecord::Migration
  def change
    add_column :computers, :current_username, :string
  end
end
