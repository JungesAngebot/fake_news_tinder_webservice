class QuizController < ApplicationController
  layout 'quiz'

  def quiz
    c = ApplicationController.new
    @quiz_json = c.render_to_string( partial: '/api/v1/quizzes/show.json.jbuilder', locals: { quiz: Quiz.first}).html_safe

  end
end
