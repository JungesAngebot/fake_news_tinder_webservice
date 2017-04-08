module NotificationHelper
  APP_NAME = 'JobDone'

  def send_notification_to(user, text, app)
    # if user.profile.nil?
    #   logger.warn "Profile of user #{user.email} is not available"
    #   return
    # end
    #
    # if user.profile.notification_token.nil?
    #   logger.warn "Notification token of user #{user.email} is not available"
    #   return
    # end

    device_ids = user.devices.map(&:id).compact.uniq

    if device_ids.empty?
      logger.info "Notification token of user #{user.email} is not available"
    else
      send_notifications(device_ids, text, app, attrs_for_device = {})

      logger.info "Status notification with message: #{text} was sent to user: #{user.email}"
    end
  end

  def send_notifications(device_ids, message, app, attrs_for_device = {})
    return if Rails.env == "test"
    android_tokens = Device.where(os: "android").where("id in (?)", device_ids).map(&:notification_token)
    android_tokens.compact!
    android_tokens.uniq!

    ios_tokens = Device.where(os: "ios").where("id in (?)", device_ids).map(&:notification_token)
    ios_tokens.compact!
    ios_tokens.uniq!

    message_prefix = Rails.env == 'production' ? '' : '#'
    message = message_prefix + message
    attrs_for_device.merge!({ env: Rails.env })

    send_notifications_to_ios(ios_tokens, message, app, attrs_for_device)
    send_notifications_to_android(android_tokens, message, app, attrs_for_device)
  end


  private

  def send_notifications_to_ios(notification_tokens, message, app, attrs_for_device)
    notification_tokens.each do |notification_token|
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("#{notification_env}_apns")
      n.alert = message
      n.attributes_for_device = attrs_for_device

      n.device_token = notification_token
      n.save!
    end
  end

  def send_notifications_to_android(notification_tokens, message, app, attrs_for_device)
    notification_tokens.each do |notification_token|
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name("#{notification_env}_gcm")
      n.data = { message: message, title: APP_NAME }.merge(attrs_for_device)

      n.registration_ids = [notification_token]
      n.save!
    end
  end

  private

    def notification_env
      Rails.env == 'production' ? 'prod' : 'dev'
    end

end