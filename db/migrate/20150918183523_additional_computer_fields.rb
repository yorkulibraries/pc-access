class AdditionalComputerFields < ActiveRecord::Migration
  def change
    add_column :computers, :area_id, :integer
    add_column :computers, :offline, :boolean, null: false, default: false
    add_column :computers, :hostname, :string
  end
end
