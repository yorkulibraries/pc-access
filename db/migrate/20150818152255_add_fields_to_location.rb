class AddFieldsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :map, :string
    add_column :locations, :ip_subnet, :string   
  end
end
