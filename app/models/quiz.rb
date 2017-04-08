class Quiz < ApplicationRecord
  scope :for_user, -> (user) do
    all
  end
end
