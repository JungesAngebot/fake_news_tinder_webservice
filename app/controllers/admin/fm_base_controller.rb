module Admin
    class FmBaseController < ::ApplicationController
      layout 'admin/admin'

      include FilterSimpleSearch

      before_action :authenticate_user!
      before_action :authenticate_admin!

      def admin_authenticated_nothing
        render html: '', layout: 'admin/admin'
      end

      protected
        def authenticate_admin!
          raise User::NotAuthorized unless current_user.admin? or current_user.super_admin?
        end

        def authenticate_super_admin!
          raise User::NotAuthorized unless current_user.super_admin?
        end
    end
end