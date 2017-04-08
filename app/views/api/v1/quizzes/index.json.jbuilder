json.array!(@quizzes) do |quiz|
  json.partial! 'quizzes/show', quiz: quiz
end
