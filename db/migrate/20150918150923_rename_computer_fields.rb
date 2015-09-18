class RenameComputerFields < ActiveRecord::Migration
  def change
    rename_column :computers, :last_user_activity, :last_user_activity
    add_column :computers, :image_id, :integer
  end
end
