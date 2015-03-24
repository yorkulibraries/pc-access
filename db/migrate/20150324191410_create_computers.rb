class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :ip
      t.boolean :occupied

      t.timestamps null: false
    end
  end
end
