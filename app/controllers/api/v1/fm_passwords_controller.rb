module Api
  module V1
    class FmPasswordsController < Devise::PasswordsController
      skip_before_action :verify_authenticity_token
      respond_to :json
      wrap_parameters :user

      api :POST, '/v1/password', 'Forgot Password Step 1: Request password reset instructions'
      param :user, Hash do
        param :email, :undef
      end
      error code: 422
      def create
        self.resource = User.find_or_initialize_with_errors(User.reset_password_keys, resource_params, :not_found)
        if resource.persisted?
          token = resource.set_reset_password_token
          resource.send_devise_notification(:reset_password_instructions, token, template_path: '/api/v1/devise/mailer')
        end
        yield resource if block_given?

        if successfully_sent?(resource)
          respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
        else
          respond_with(resource)
        end
      end

      api :GET, '/v1/password/edit', 'Forgot Password Step 2: Redirects to the app'
      def edit
        redirect_to "#{Rails.application.config.app_url_scheme}://forgot_password?reset_password_token=#{params[:reset_password_token]}"
      end

      api :PUT, '/v1/password', 'Set new Password: Update your password'
      param :user, Hash do
        param :password, :undef
        param :password_confirmation, :undef
        param :reset_password_token, :undef
      end
      error code: 422
      def update
        super
      end
    end
  end
end