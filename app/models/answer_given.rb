class AnswerGiven < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :information
  belongs_to :answer

  scope :for_user, -> (user) do
    none
  end

  def grant_write_access?(user)
    true
  end
end
