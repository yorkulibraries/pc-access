class CreateComputerActivityLogs < ActiveRecord::Migration
  def change
    create_table :computer_activity_logs do |t|
      t.integer :computer_id
      t.string :ip
      t.datetime :activity_date
      t.string :action
      t.string :username

      t.timestamps null: false
    end
  end
end
