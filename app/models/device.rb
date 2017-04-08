class Device < ActiveRecord::Base
  include Tombstoning

  belongs_to :user

  before_create :generate_uuid

  private

  def generate_uuid
    return if self.uuid
    begin
      self.uuid = SecureRandom.hex
    end while self.class.exists?(uuid: uuid)
  end
end
