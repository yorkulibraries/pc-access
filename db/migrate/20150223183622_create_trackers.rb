class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.string :ip

      t.timestamps null: false
    end
  end
end
