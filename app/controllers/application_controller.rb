class ApplicationController < ActionController::Base

  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  before_action :authenticate_user!, only: [:nothing]

  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from User::NotAuthorized, with: :user_not_authorized
  # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  # rescue_from ActionController::RoutingError, with: :routing_error

  unless Rails.application.config.consider_all_requests_local
    # rescue_from Exception, :with => :render_error
    # rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    # rescue_from ActionController::RoutingError, :with => :render_not_found
  end

  #called by last route matching unmatched routes.  Raises RoutingError which will be rescued from in the same way as other exceptions.
  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  #render 500 error
  # def render_error(e)
  #   respond_to do |format|
  #     format.all{ render plain: '500 Internal Server error', status: :internal_server_error }
  #   end
  # end

  def nothing
    redirect_to admin_root_path
  end


  protected

    def should_rescue?
      Rails.env.production? || Rails.env.test?
    end

    def record_not_found(exception)
      if should_rescue?
        render plain: '404 Not Found', status: :not_found
      else
        raise exception
      end
    end

    def render_not_found(exception)
      if should_rescue?
        render plain: '404 Not Found', status: :not_found
      else
        raise exception
      end
    end

    def record_invalid(exception)
      if should_rescue?
        render plain: '422 Unprocessable entity (Record invalid)', status: :unprocessable_entity
      else
        raise exception
      end
    end

    def user_not_authorized(exception)
      logger.warn 'user_not_authorized'
      render plain: '401 Unauthorized', status: :unauthorized
    end

    def routing_error(exception)
      if should_rescue?
        render plain: '404 Not found', status: :not_found
      else
        raise exception
      end
    end

end
