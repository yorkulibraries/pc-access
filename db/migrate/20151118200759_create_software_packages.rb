class CreateSoftwarePackages < ActiveRecord::Migration
  def change
    create_table :software_packages do |t|
      t.string :name
      t.string :version
      t.string :note
      t.integer :image_id

      t.timestamps null: false
    end
  end
end
