class Quiz < ApplicationRecord
  has_many :quiz_informations
  has_many :informations, through: :quiz_informations

  scope :for_user, -> (user) do
    all
  end
end
