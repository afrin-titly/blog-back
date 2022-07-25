class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:email])

    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(email: @user.email)
      render json: {
        token: token,
        name: @user.first_name + " " + @user.last_name,
        user: @user.id,
        message: "Logged in successfully"
      }, status: :ok
    else
      return render json: {
        error: 'Email/password is wrong.'
      }, status: :ok
    end
  end

  def login_params
    params.permit(:email, :password)
  end
end
