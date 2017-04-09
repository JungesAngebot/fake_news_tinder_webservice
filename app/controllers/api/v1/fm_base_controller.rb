module Api
  module V1
    class FmBaseController < ::ApplicationController

      skip_before_action :verify_authenticity_token

      before_action :prepend_api_version_view_path

      def prepend_api_version_view_path
        prepend_view_path Rails.root.join('app', 'views', 'api', 'v1')
      end

      resource_description do
        api_versions 'v1'
      end

      protected

        def authenticate!
            sign_in create_guest_user, store: false, scope: :user
        end


      def create_guest_user
        u = User.create(:email => "guest_#{SecureRandom.hex}@#{User::GUEST_EMAIL}")
        u.save!(:validate => false)
        u
      end

    end
  end
end