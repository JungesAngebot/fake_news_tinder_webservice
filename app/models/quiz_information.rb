class QuizInformation < ApplicationRecord
  belongs_to :quiz
  belongs_to :information
  scope :for_user, -> (user) do
    all
  end
end
