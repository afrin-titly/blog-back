class UsersController < ApplicationController
  before_action :authorize_request, except: [:create, :confirm_user]
  before_action :authenticate_admin, only: [:destroy]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :user?, only: [:update]

  # GET /users
  def index
    # @users = User.all

    # render json: @users
    suggest_to_follow = @current_user.suggest_to_follow
    render json: {
      suggest_to_follow: suggest_to_follow
    }

  end

  # GET /users/1
  def show
    render json: {
      user: {
        name: @user.first_name + " " + @user.last_name,
        is_following: @current_user.followers_list.pluck(:follow).include?(@user.id)
      }
    }
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.confirmation_token = JsonWebToken.encode(email: @user.email, exp: 1.day.from_now)
    if @user.save
      #FIX: doesn't send actual email from localhost
      UserMailer.send_on_registration( @user.email, @user.confirmation_token).deliver_now
      render json: {
        message: "An email has been sent. Please confirm it."
      }, status: :created
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  # GET
  def confirm_user
    begin
      decoded = JsonWebToken.decode(params[:token])
      user = User.find_by_email(decoded[:email])
      if user
        user.confirmed_at = Time.now
        user.save
        # render json: { message: "Successfully confirmed account"}, status: :ok
        # redirect_to "http://localhost:8080/", json: { message: "Confirmed!"}
        render json: { location: "http://localhost:8080/login" }
      else
        render json: { message: "User not found."}, status: :unprocessable_entity
      end
    rescue JWT::DecodeError => e
      render json: { error: "Token has been expired or #{e}"}, status: :unauthorized
    end
  end

  #TODO: handle if user doesn't receive token in email.

  # PATCH/PUT /users/1
  def update
    if params[:user][:email]
      return render json: { error: "You can not change your email. If it's really needed contact with the Admin."}, status: :unprocessable_entity
    end
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password_digest)
    end

    def user?
      return if @current_user.admin? || @current_user.id == @user.id
      render json: { error: "Permission denied."}
    end
end
