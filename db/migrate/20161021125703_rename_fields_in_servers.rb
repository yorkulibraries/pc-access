class RenameFieldsInServers < ActiveRecord::Migration
  def change
    rename_column :servers, :administrator, :public_used_by
    rename_column :servers, :note, :local_used_by
    rename_column :servers, :os_version, :local_hostname

    remove_column :servers, :cnames
    remove_column :servers, :os_name
  end
end
