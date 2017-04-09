class Quiz < ApplicationRecord
  has_many :quiz_informations
  has_many :informations, through: :quiz_informations

  accepts_nested_attributes_for :quiz_informations, :allow_destroy => true

  scope :for_user, -> (user) do
    all
  end
end
