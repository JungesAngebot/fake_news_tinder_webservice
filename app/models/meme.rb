class Meme < ApplicationRecord
  belongs_to :category
  scope :for_user, -> (user) do
    all
  end

end
