class User < ActiveRecord::Base
  GUEST_EMAIL = "guest.com"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include Tombstoning
  include PermissionContext

  has_many :devices, dependent: :destroy

  validates :password, confirmation: true, if: :guest?
  validates :password, :password_confirmation, presence: true, if: :guest?
  validate :password_complexity

  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  def guest?
    self.email.ends_with?(GUEST_EMAIL)
  end

  def user_uuid
    return self.uuid if self.uuid
    begin
      self.uuid = SecureRandom.hex
    end while self.class.exists?(uuid: uuid)
    self.update_column(:uuid, self.uuid)
    self.uuid
  end

  class NotAuthorized < Exception
  end

  def self.required_fields(klass)
    [:current_sign_in_at, :last_sign_in_at, :sign_in_count]
  end

  def update_tracked_fields(request)
    old_current, new_current = self.current_sign_in_at, Time.now.utc
    self.last_sign_in_at     = old_current || new_current
    self.current_sign_in_at  = new_current

    self.sign_in_count ||= 0
    self.sign_in_count += 1
  end

  def update_tracked_fields!(request)
    update_tracked_fields(request)
    save(validate: false)
  end

  # hack for api specific devise reset password templates
  def set_reset_password_token
    super
  end

  def send_devise_notification(notification, *args)
    super
  end
end
