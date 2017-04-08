class AnswerGiven < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :information
  belongs_to :answer
end
