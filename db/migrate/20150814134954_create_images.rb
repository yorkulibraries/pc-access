class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :os_name
      t.string :os_version

      t.timestamps null: false
    end
  end
end
