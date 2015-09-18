class AdditionalComputerFields < ActiveRecord::Migration
  def change
    add_column :computers, :area_id, :integer
    add_column :computers, :offline, :boolean, null: false, default: false
    add_column :computers, :hostname, :string
    rename_column :computers, :last_user_activity, :last_user_activity
    add_column :computers, :image_id, :integer

    add_column :locations, :active, :boolean, null: false, default: true
  end
end
