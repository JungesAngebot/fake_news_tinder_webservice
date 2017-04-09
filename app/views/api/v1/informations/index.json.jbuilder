json.array!(@informations) do |information|
  json.partial! 'informations/show', information: information
end
