module Api
  module V1
    class FmJwtTokenController < FmBaseController

      before_action :authenticate!, only: [:show, :destroy]

      api :GET, '/v1/jwt_token', 'Re-Login: Get a new jwt token with updated expiration when authenticated'
      error code: 401
      def show
        @token = JsonWebTokenHelper.encode('user_id' => current_user.id)

        respond_to do |format|
          format.json { render json: {'token' => @token} }
        end
      end

      api :POST, '/v1/jwt_token', 'Login: Create a jwt token (Expires after 7 days)'
      param :password, :undef
      param :username, :undef
      def create
        @user = User.find_by(email: params[:username])

        respond_to do |format|
          if !@user.nil? and @user.valid_password?(params[:password])
            @token = JsonWebTokenHelper.encode('user_id' => @user.id)
            format.json { render json: {'token' => @token} }
          else
            format.json { render json: {'error' => 'wrong username or password'}, status: :unauthorized}
          end
        end
      end

      api :DELETE, '/v1/jwt_token', 'Logout: Delete device'
      def destroy
        if current_device.destroy
          head :no_content
        else
          head :internal_server_error
        end
      end

    end
  end
end
