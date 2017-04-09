class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Tombstoning
  include ProtectedModel
end
