json.array!(@answers) do |answer|
  json.partial! 'answers/show', answer: answer
end
