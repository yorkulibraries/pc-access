class AddDeletedFlagsToLocationAndImages < ActiveRecord::Migration
  def change
      add_column :images, :deleted, :boolean, null: false, default: false unless column_exists? :images, :deleted
      add_column :locations, :deleted, :boolean, null: false, default: false unless column_exists? :locations, :deleted
  end
end
