class FmApplicationRecord < ApplicationRecord
  self.abstract_class = true

  include BeIdHandler
  include ProtectedModel
  include Tombstoning

  scope :for_user, -> (user) do
    none
  end

  def grant_write_access?(user)
    false
  end
end