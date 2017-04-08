json.array!(@quiz_informations) do |quiz_information|
  json.partial! 'quiz_informations/show', quiz_information: quiz_information
end
