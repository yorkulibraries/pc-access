class ReorgLocationAndComputersModels < ActiveRecord::Migration
  def change
    ### LOCATIONS CHANGES
    rename_column :locations, :ip_subnet, :ip_subnets unless column_exists? :locations, :ip_subnet
    remove_column :locations, :map unless column_exists? :locations, :map
    remove_column :locations, :active unless column_exists? :locations, :active

    add_column :locations, :floors, :integer
    add_coumnn :locations, :address, :string

    ## COMPUTER CHANGES
    add_coumnn :computers, :floor_id, :integer
    add_coumnn :computers, :general_usage, :string

  end
end
