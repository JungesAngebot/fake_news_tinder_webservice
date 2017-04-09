class Category < ApplicationRecord
  has_many :memes

  scope :for_user, -> (user) do
    all
  end
end
