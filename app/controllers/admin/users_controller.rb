module Admin
  class UsersController < FmBaseController
    before_action :authenticate_admin!

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
      @users = User.where(super_admin: false)
      @users = filter_simple_search(@users, :id, :email, :first_name, :last_name)
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      rand_password = ('A'..'Z').to_a.shuffle.first(1).join
      rand_password += ('a'..'z').to_a.shuffle.first(7).join
      rand_password += ('0'..'9').to_a.shuffle.first(2).join
      @user.password = @user.password_confirmation = rand_password

      respond_to do |format|
        if @user.save
          mail = UserCreatedMailer.user_created(current_user, @user, rand_password)
          Rails.env.development? ? mail.deliver_now! : mail.deliver_later!
          format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      password_given = !user_params[:password].blank?
      respond_to do |format|
        if password_given ? @user.update(user_params) : @user.update_without_password(user_params)
          format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if current_user.super_admin?
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :admin)
      else
        params.require(:user).permit(:email, :first_name, :last_name, :admin)
      end
    end
  end
end