class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :hostname
      t.string :public_ip
      t.string :local_ip
      t.string :os_name
      t.string :os_version
      t.boolean :public_ip_used
      t.boolean :local_ip_used
      t.datetime :last_ping
      t.string :note
      t.string :administrator

      t.timestamps null: false
    end
  end
end
