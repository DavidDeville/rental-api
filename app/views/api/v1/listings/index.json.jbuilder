json.array! @listings do |listing|
  json.extract! listing, :num_rooms
end
