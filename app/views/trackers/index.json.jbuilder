json.array!(@trackers) do |tracker|
  json.extract! tracker, :id, :ip
  json.url tracker_url(tracker, format: :json)
end
