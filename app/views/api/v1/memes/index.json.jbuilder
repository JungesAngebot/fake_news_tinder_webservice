json.array!(@memes) do |meme|
  json.partial! 'memes/show', meme: meme
end
