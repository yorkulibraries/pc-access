class ReorgLocationAndComputersModels < ActiveRecord::Migration
  def change

    ### LOCATIONS CHANGES
    rename_column :locations, :ip_subnet, :ip_subnets unless column_exists? :locations, :ip_subnets
    remove_column :locations, :map unless column_exists? :locations, :map
    remove_column :locations, :active unless column_exists? :locations, :active

    add_column :locations, :floors, :integer
    add_column :locations, :address, :string

    ## COMPUTER CHANGES
    add_column :computers, :floor_id, :integer
    add_column :computers, :general_usage, :string

  end
end
