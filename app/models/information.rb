class Information < ApplicationRecord
  belongs_to :information_type
  belongs_to :correct_answer
  belongs_to :category

  scope :for_user, -> (user) do
    all
  end
end
