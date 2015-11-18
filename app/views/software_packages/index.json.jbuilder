json.array!(@software_packages) do |software_package|
  json.extract! software_package, :id, :name, :version, :note, :image_id
  json.url software_package_url(software_package, format: :json)
end
