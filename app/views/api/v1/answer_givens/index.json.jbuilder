json.array!(@answer_givens) do |answer_given|
  json.partial! 'answer_givens/show', answer_given: answer_given
end
