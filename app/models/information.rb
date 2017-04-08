class Information < ApplicationRecord
  belongs_to :information_type
  belongs_to :correct_answer, class_name: 'Answer'
  belongs_to :category

  def answers
    self.information_type.answers
  end

  scope :for_user, -> (user) do
    all
  end
end
