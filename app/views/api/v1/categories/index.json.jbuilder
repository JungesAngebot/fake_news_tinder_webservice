json.array!(@categories) do |category|
  json.partial! 'categories/show', category: category
end
