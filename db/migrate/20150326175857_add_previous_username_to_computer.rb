class AddPreviousUsernameToComputer < ActiveRecord::Migration
  def change
    add_column :computers, :previous_username, :string
  end
end
