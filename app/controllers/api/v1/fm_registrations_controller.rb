module Api
  module V1
    class FmRegistrationsController < Devise::RegistrationsController
      skip_before_action :verify_authenticity_token
      respond_to :json
      wrap_parameters :user

      api :PUT, '/v1/users', 'Change Password: Change password when authenticated'
      param :user, Hash do
        param :current_password, :undef
        param :password, :undef
        param :password_confirmation, :undef
      end
      def update
        super
      end
    end
  end
end