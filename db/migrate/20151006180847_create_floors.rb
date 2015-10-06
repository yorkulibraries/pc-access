class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.string :name
      t.integer :positition
      t.boolean :deleted, null: false, default: false 
      t.string :map
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
