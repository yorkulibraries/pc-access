class AddDeletedFlagsToLocationAndImages < ActiveRecord::Migration
  def change
      add_column :images, :deleted, :boolean, null: false, default: false
      add_column :locations, :deleted, :boolean, null: false, default: false
  end
end
