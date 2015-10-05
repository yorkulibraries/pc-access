class AdditionalComputerFields < ActiveRecord::Migration
  def change

    add_column :computers, :area_id, :integer unless column_exists? :computers, :area_id
    add_column :computers, :offline, :boolean, null: false, default: false unless column_exists? :computers, :offline
    add_column :computers, :hostname, :string unless column_exists? :computers, :hostname
    rename_column :computers, :last_keep_alive, :last_user_activity unless column_exists? :computers, :last_user_activity
    add_column :computers, :image_id, :integer unless column_exists? :computers, :image_id

    # Locations
    add_column :locations, :active, :boolean, null: false, default: true unless column_exists? :locations, :active
  end
end
