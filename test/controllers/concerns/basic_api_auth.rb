module BasicApiAuth
  extend ActiveSupport::Concern

  included do
    def basic_api_auth(user = nil)
      @request.headers['X-Api-Token'] = ENV['API_TOKEN']
      sign_in user, scope: :user if user
      # if user
      #   device = Device.new
      #   device.user = user
      #   device.save
      #   @request.headers['X-Device-Uuid'] = device.uuid
      # end
    end
  end

  module ClassMethods
  end
end