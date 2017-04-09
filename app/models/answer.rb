class Answer < ApplicationRecord
  belongs_to :information_type

  scope :for_user, -> (user) do
    all
  end
end
