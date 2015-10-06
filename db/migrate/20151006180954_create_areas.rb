class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :department
      t.string :map
      t.text :notes
      t.boolean :special_access, null: false, default: false
      t.boolean :deleted, null: false, default: false 
      t.integer :location_id
      t.integer :floor_id

      t.timestamps null: false
    end
  end
end
