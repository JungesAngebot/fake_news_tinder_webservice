json.array!(@information_types) do |information_type|
  json.partial! 'information_types/show', information_type: information_type
end
