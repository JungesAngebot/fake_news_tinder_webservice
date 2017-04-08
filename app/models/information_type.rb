class InformationType < ApplicationRecord
  has_many :answers
  has_many :informations

  scope :for_user, -> (user) do
    all
  end

end
