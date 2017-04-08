module Devise
  module Strategies
    class JwtAuthenticatable < Base
      def valid?
        !request.headers['Authorization'].nil?
      end

      def authenticate!
        if claims and user = User.find_by(id: claims.fetch('user_id'))
          success! user
        else
          fail!
        end
      end

      private

      def claims
        auth_header = request.headers['Authorization'] and token = auth_header.split(' ').last and ::JsonWebTokenHelper.decode(token)
      rescue
        nil
      end
    end
  end
end

Warden::Strategies.add(:jwt_authenticatable, Devise::Strategies::JwtAuthenticatable)