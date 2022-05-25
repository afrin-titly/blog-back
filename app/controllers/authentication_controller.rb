class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(email: @user.email)
      time = Time.now + 1.hour.to_i
      render json: {
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        username: "#{@user.first_name} #{@user.last_name}"
      }, status: :ok
    else
      render json: {
        error: 'unauthorized'
      }, status: :unauthorized
    end
  end

  def login_params
    params.permit(:email, :password)
  end
end
