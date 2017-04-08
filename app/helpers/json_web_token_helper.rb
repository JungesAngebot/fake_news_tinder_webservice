module JsonWebTokenHelper

  def self.encode(payload, expiration = 7.days.from_now)
    payload = payload.dup
    payload['exp'] = expiration.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, verify_expiration: false).first
  end

end