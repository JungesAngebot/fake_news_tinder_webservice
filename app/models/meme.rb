class Meme < ApplicationRecord
  belongs_to :category

  mount_uploader :image_url, DefaultPictureUploader

  scope :for_user, -> (user) do
    all
  end
end
