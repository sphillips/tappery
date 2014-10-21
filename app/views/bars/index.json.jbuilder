json.array!(@bars) do |bar|
  json.extract! bar, :id
  json.url bar_url(bar, format: :json)
end
