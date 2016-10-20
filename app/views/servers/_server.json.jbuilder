json.extract! server, :id, :hostname, :public_ip, :local_ip, :os_name, :last_ping, :note, :administrator, :created_at, :updated_at
json.url server_url(server, format: :json)